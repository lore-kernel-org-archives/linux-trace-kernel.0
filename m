Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB7E20296A;
	Fri,  2 May 2025 20:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746219229; cv=none; b=ixUuGTT+n14DzQ7g34yD65+EbLc8Sp1xQE7hoHCVVxqCiMGMfUmKjCm9m50cGtFeDMJJoFV/zB+1rxXqTGsAxRMO1VX5i662JlVFnY99opDqTz07S/5Y3qCV1pqQpme2IUgrhFsjmvlNYRMUMUQenGkgxF0kED1j3iimA0aJ+gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746219229; c=relaxed/simple;
	bh=XN5M+G+GG6rlRQyIqM1WZQZvm+6qsb8A6OZxP+hWE8s=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=VJ7jmUc13RVl41XWcmepKDK6h2VE2OhPMmsNDD/rE1DWXJxBHoy3xAQ025UCXybS5GAO9y7asVU6Bt6iYC0SJER33q+0Mbo3aQoGkv8Fl1b0l85OFOjNEPQurMGRANgYnw/wkbOEhB2CKd4RXIwPBc/B6jKPn3/5w0BopevNhCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 903EEC4CEF1;
	Fri,  2 May 2025 20:53:48 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uAxOG-000000006A8-1BE0;
	Fri, 02 May 2025 16:53:48 -0400
Message-ID: <20250502205348.131916206@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 02 May 2025 16:51:49 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 02/12] tracing: Do not bother setting "disabled" field for ftrace_dump_one()
References: <20250502205147.283272733@goodmis.org>
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
The code already calls tracer_tracing_off() which disables the ring
buffer, there's no reason to use the "disabled" flags.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 8ddf6b17215c..bae32778b292 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -10445,7 +10445,7 @@ static void ftrace_dump_one(struct trace_array *tr, enum ftrace_dump_mode dump_m
 	static struct trace_iterator iter;
 	unsigned int old_userobj;
 	unsigned long flags;
-	int cnt = 0, cpu;
+	int cnt = 0;
 
 	/*
 	 * Always turn off tracing when we dump.
@@ -10462,10 +10462,6 @@ static void ftrace_dump_one(struct trace_array *tr, enum ftrace_dump_mode dump_m
 	/* Simulate the iterator */
 	trace_init_iter(&iter, tr);
 
-	for_each_tracing_cpu(cpu) {
-		atomic_inc(&per_cpu_ptr(iter.array_buffer->data, cpu)->disabled);
-	}
-
 	old_userobj = tr->trace_flags & TRACE_ITER_SYM_USEROBJ;
 
 	/* don't look at user memory in panic mode */
@@ -10523,9 +10519,6 @@ static void ftrace_dump_one(struct trace_array *tr, enum ftrace_dump_mode dump_m
 
 	tr->trace_flags |= old_userobj;
 
-	for_each_tracing_cpu(cpu) {
-		atomic_dec(&per_cpu_ptr(iter.array_buffer->data, cpu)->disabled);
-	}
 	local_irq_restore(flags);
 }
 
-- 
2.47.2


