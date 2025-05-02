Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26682202961;
	Fri,  2 May 2025 20:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746219229; cv=none; b=l4osMOI64T1yA3oT/CPQlqKfuuJLOPOIpytMaERCTsBTioAXuZAxaNmvQSRaDCRWVg3SEmWCGTEeCY63fMshdItmL+6YRL7WDYiZpA2fiF9DBlpY6roZXXCWr1DPkzqopnErzgTDansmirPEsrJ4ozvBy3ZVMCwOyZlhMjMoC0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746219229; c=relaxed/simple;
	bh=UhlkJQmGdRqpLD2EEhmHlUnthvoNi84W9rp7qzGQuxc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=peFeWj7i+jR+agsMYiMwevPi0e/U3BHLDDB6yok+q4vC5sOjvKQCDQ0V6Fv+xCkDIpkJsWOZUzwxg7vMGHkm/Y3FUgb05fytLGSsUtlokmuYSQP7+n3T1+U1jPlK7XVeOoFLGQFT49/JyTfkFjaOnGvutRLfeiGu1jnzw56rErU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B981C4CEE4;
	Fri,  2 May 2025 20:53:49 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uAxOG-000000006Ba-3J83;
	Fri, 02 May 2025 16:53:48 -0400
Message-ID: <20250502205348.643055437@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 02 May 2025 16:51:52 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jason Wessel <jason.wessel@windriver.com>,
 Daniel Thompson <danielt@kernel.org>,
 Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 05/12] tracing: kdb: Use tracer_tracing_on/off() instead of setting per CPU
 disabled
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

The kdb_ftdump() function iterates over all the current tracing CPUs and
increments the "disabled" counter before doing the dump, and decrements it
afterward.

As the disabled flag can be ignored, doing this today is not reliable.
Instead, simply call tracer_tracing_off() and then tracer_tracing_on() to
disable and then enabled the entire ring buffer in one go!

Cc: Jason Wessel <jason.wessel@windriver.com>
Cc: Daniel Thompson <danielt@kernel.org>
Cc: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_kdb.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_kdb.c b/kernel/trace/trace_kdb.c
index 1e72d20b3c2f..b5cf3fdde8cb 100644
--- a/kernel/trace/trace_kdb.c
+++ b/kernel/trace/trace_kdb.c
@@ -120,9 +120,7 @@ static int kdb_ftdump(int argc, const char **argv)
 	trace_init_global_iter(&iter);
 	iter.buffer_iter = buffer_iter;
 
-	for_each_tracing_cpu(cpu) {
-		atomic_inc(&per_cpu_ptr(iter.array_buffer->data, cpu)->disabled);
-	}
+	tracer_tracing_off(iter.tr);
 
 	/* A negative skip_entries means skip all but the last entries */
 	if (skip_entries < 0) {
@@ -135,9 +133,7 @@ static int kdb_ftdump(int argc, const char **argv)
 
 	ftrace_dump_buf(skip_entries, cpu_file);
 
-	for_each_tracing_cpu(cpu) {
-		atomic_dec(&per_cpu_ptr(iter.array_buffer->data, cpu)->disabled);
-	}
+	tracer_tracing_on(iter.tr);
 
 	kdb_trap_printk--;
 
-- 
2.47.2


