Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6682749C3;
	Mon,  5 May 2025 21:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746480149; cv=none; b=dDGoCKeaYZRHX3zNL1JZIf7eZfvjlFOqqxIWKqEqpGYwuWtXTd803Eu02xZ6si0qlLSvC2Rf+pqpJxErs6qcNgDFnrRhzoWVxZ3WTaa5s9QDXifarHTpwtJ5KtuXwGHZom8Jc+a6X/aM+UkB3Yyph3UWDZts9UK/AB02b8d1/s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746480149; c=relaxed/simple;
	bh=RxtgXCfcqWA6ooX95AsP5Gn57jVm1MgA5swttk/JuWo=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=esLNtEi8SyMKc9gx+7elluFX+9zwK01Yn2yLhIA61e4VWm9VazK6yB98bCwVKIlZ25rUalAPBDNudAKXJ6GFCGg2pg1H8k1xKJ/G9ceBaMJwdb/7QmxtUXcNVIhXMcZWmFX6kK52zHZLWLhCAEoA0IQ0DMAcsz1Ae8p3fZnoJFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE137C4CEED;
	Mon,  5 May 2025 21:22:28 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uC3Gl-00000000yDE-2DL1;
	Mon, 05 May 2025 17:22:35 -0400
Message-ID: <20250505212235.381188238@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 05 May 2025 17:21:09 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 05/13] tracing: Use tracer_tracing_disable() instead of "disabled" field for
 ftrace_dump_one()
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

The ftrace_dump_one() function iterates over all the current tracing CPUs and
increments the "disabled" counter before doing the dump, and decrements it
afterward.

As the disabled flag can be ignored, doing this today is not reliable.
Instead use the new tracer_tracing_disable() that calls into the ring
buffer code to do the disabling.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://lore.kernel.org/20250502205348.131916206@goodmis.org

- Use tracer_tracing_disable() instead of tracer_tracing_on()

 kernel/trace/trace.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index e36b1244fa82..490c24271a3d 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -10481,7 +10481,7 @@ static void ftrace_dump_one(struct trace_array *tr, enum ftrace_dump_mode dump_m
 	static struct trace_iterator iter;
 	unsigned int old_userobj;
 	unsigned long flags;
-	int cnt = 0, cpu;
+	int cnt = 0;
 
 	/*
 	 * Always turn off tracing when we dump.
@@ -10498,9 +10498,8 @@ static void ftrace_dump_one(struct trace_array *tr, enum ftrace_dump_mode dump_m
 	/* Simulate the iterator */
 	trace_init_iter(&iter, tr);
 
-	for_each_tracing_cpu(cpu) {
-		atomic_inc(&per_cpu_ptr(iter.array_buffer->data, cpu)->disabled);
-	}
+	/* While dumping, do not allow the buffer to be enable */
+	tracer_tracing_disable(tr);
 
 	old_userobj = tr->trace_flags & TRACE_ITER_SYM_USEROBJ;
 
@@ -10559,9 +10558,7 @@ static void ftrace_dump_one(struct trace_array *tr, enum ftrace_dump_mode dump_m
 
 	tr->trace_flags |= old_userobj;
 
-	for_each_tracing_cpu(cpu) {
-		atomic_dec(&per_cpu_ptr(iter.array_buffer->data, cpu)->disabled);
-	}
+	tracer_tracing_enable(tr);
 	local_irq_restore(flags);
 }
 
-- 
2.47.2


