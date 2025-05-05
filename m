Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EEE27465A;
	Mon,  5 May 2025 21:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746480148; cv=none; b=Fe1XEmxQ8F7wNGJtpXhTqBEp0CB0S7SUE/DFcefMdnrK6a5YAPOAf5KZlVaaXafqYvqYlU/kKsQCPfKvbtFqwO9MAI1tfnXvF0spLIvJ+pPQ6nexMbg7HTWygDzNpX5uZPqkxl544xfy+VNIBkllK3PSVT/X5QcPis8ICWEirBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746480148; c=relaxed/simple;
	bh=e2yzUrlsAIvxL3H3QyPwr4CTnM9tzN8vsHBbBq12A7c=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=RaMWZwMmu3omfZd6UEwoRnyh2/82vBR0EQMWiSVd4yNGxWcIpZCFGgw05QWrQcq8j2CVAF+B+/UgsdZKK5EXXPMmtKDEBUL2fDx9Ojx9L6By9d2ebPzdoQzS/1YF/8eYLOHvAW+bLMjLVAdytCDBSQhpJcKmq+4bANUE0Cfdl0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9795C4CEF1;
	Mon,  5 May 2025 21:22:28 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uC3Gl-00000000yDj-2uat;
	Mon, 05 May 2025 17:22:35 -0400
Message-ID: <20250505212235.549033722@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 05 May 2025 17:21:10 -0400
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
Subject: [PATCH v2 06/13] tracing: kdb: Use tracer_tracing_on/off() instead of setting per CPU
 disabled
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
Changes since v2: https://lore.kernel.org/20250502205348.643055437@goodmis.org

- Fixed unused "int cpu;" (kernel test robot)

- Use the new tracer_tracing_disable() instead of tracer_tracing_off()
  (Doug Anderson)

 kernel/trace/trace_kdb.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/trace_kdb.c b/kernel/trace/trace_kdb.c
index 1e72d20b3c2f..d7b135de958a 100644
--- a/kernel/trace/trace_kdb.c
+++ b/kernel/trace/trace_kdb.c
@@ -98,7 +98,6 @@ static int kdb_ftdump(int argc, const char **argv)
 	long cpu_file;
 	int err;
 	int cnt;
-	int cpu;
 
 	if (argc > 2)
 		return KDB_ARGCOUNT;
@@ -120,9 +119,7 @@ static int kdb_ftdump(int argc, const char **argv)
 	trace_init_global_iter(&iter);
 	iter.buffer_iter = buffer_iter;
 
-	for_each_tracing_cpu(cpu) {
-		atomic_inc(&per_cpu_ptr(iter.array_buffer->data, cpu)->disabled);
-	}
+	tracer_tracing_disable(iter.tr);
 
 	/* A negative skip_entries means skip all but the last entries */
 	if (skip_entries < 0) {
@@ -135,9 +132,7 @@ static int kdb_ftdump(int argc, const char **argv)
 
 	ftrace_dump_buf(skip_entries, cpu_file);
 
-	for_each_tracing_cpu(cpu) {
-		atomic_dec(&per_cpu_ptr(iter.array_buffer->data, cpu)->disabled);
-	}
+	tracer_tracing_enable(iter.tr);
 
 	kdb_trap_printk--;
 
-- 
2.47.2


