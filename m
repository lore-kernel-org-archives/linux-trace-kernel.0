Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370292749F0;
	Mon,  5 May 2025 21:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746480149; cv=none; b=qHiWWl0+qh0Tr3Kom/hGChlLbPCO5KEsIFTkeg/7sUyMwqmW8yOoXu3DHpnRgTcmcVaXTkJdmnncuTJpAH9M7bSLH9ZXaScueRDykD2q/47sEcVjKOHklfTM2Er0XAteWLuK1UKG1o0G7eOWefHrR4wfiW49Sc/d/Rhd1DueJRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746480149; c=relaxed/simple;
	bh=G1pGPlHq1Jc2R/Q7ktIrkeXiE9v4GRByBNqYLb9M9uM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=YK9cmIyHNgzu5F+EXcEao6kN9n0fzlXp5HqcO+NJllkDcX+GYFPG/JVKfu8eD1MdDjSbTs928etkacUOrG8jIKifQ6VJmbNqX+52l7alf9mS4e3kzp+JBkGNVsCiBIpU4BVYhRtZqr1r4wCvtaqiLl+RKg0fmLWozCRf5nPObXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E7FEC4CEF1;
	Mon,  5 May 2025 21:22:29 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uC3Gm-00000000yEj-09d5;
	Mon, 05 May 2025 17:22:36 -0400
Message-ID: <20250505212235.885452497@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 05 May 2025 17:21:12 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 08/13] tracing: Do not use per CPU array_buffer.data->disabled for cpumask
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

Do not bother setting the per CPU disabled flag of the array_buffer data
to use to determine what CPUs can write to the buffer and only rely on the
ring buffer code itself to disabled it.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 490c24271a3d..395d1229da77 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5081,7 +5081,6 @@ int tracing_set_cpumask(struct trace_array *tr,
 		 */
 		if (cpumask_test_cpu(cpu, tr->tracing_cpumask) &&
 				!cpumask_test_cpu(cpu, tracing_cpumask_new)) {
-			atomic_inc(&per_cpu_ptr(tr->array_buffer.data, cpu)->disabled);
 			ring_buffer_record_disable_cpu(tr->array_buffer.buffer, cpu);
 #ifdef CONFIG_TRACER_MAX_TRACE
 			ring_buffer_record_disable_cpu(tr->max_buffer.buffer, cpu);
@@ -5089,7 +5088,6 @@ int tracing_set_cpumask(struct trace_array *tr,
 		}
 		if (!cpumask_test_cpu(cpu, tr->tracing_cpumask) &&
 				cpumask_test_cpu(cpu, tracing_cpumask_new)) {
-			atomic_dec(&per_cpu_ptr(tr->array_buffer.data, cpu)->disabled);
 			ring_buffer_record_enable_cpu(tr->array_buffer.buffer, cpu);
 #ifdef CONFIG_TRACER_MAX_TRACE
 			ring_buffer_record_enable_cpu(tr->max_buffer.buffer, cpu);
-- 
2.47.2


