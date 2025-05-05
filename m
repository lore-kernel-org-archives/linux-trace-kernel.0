Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DBA16F8E5;
	Mon,  5 May 2025 15:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746460125; cv=none; b=h+56HmCkV1Zhq7vhU+YPB6sVDkFUd18xSANyIXh0kCRVGW5WP4ptuxFmnbanTiWptPHAhJuyU7WkITKCaexQsR1LTuUOgD1ILq6tuxQw4JvEue+4jOQHrWz4/cw385YT+wCjBQCAR4mxltsywS7k6YqnRAscW/4N6iF3NtVgUgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746460125; c=relaxed/simple;
	bh=oa0sGywS0FB63vtTpXv9wl4jmko7S3Wb/y/cC9raBzs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=jOiKBCD2+p3n5Bqmk/X0jlPae9iJYPLVJHWsRhyuhdOqAem8sPyrAt4VH1gcJMn3p5/uVClGSR3ET4e08KWp7m7LaQsDeMSGcWKEgIDpkOYKh/UpMXDDwVhTTewWjWDm6fJRwaNTH7pCVmxiINV3hf4fdMQqRr2dBk0UN38zQE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3202C4CEE4;
	Mon,  5 May 2025 15:48:43 +0000 (UTC)
Date: Mon, 5 May 2025 11:48:49 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Jason Wessel
 <jason.wessel@windriver.com>, Daniel Thompson <danielt@kernel.org>, Douglas
 Anderson <dianders@chromium.org>
Subject: [PATCH v2] tracing: kdb: Use tracer_tracing_on/off() instead of
 setting per CPU disabled
Message-ID: <20250505114849.1a9237d5@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

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
Changes since v1: https://lore.kernel.org/20250502205348.643055437@goodmis.org

- Remove unused "int cpu;" (kernel test robot)

 kernel/trace/trace_kdb.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/trace_kdb.c b/kernel/trace/trace_kdb.c
index 1e72d20b3c2f..79f11f7e52df 100644
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
+	tracer_tracing_off(iter.tr);
 
 	/* A negative skip_entries means skip all but the last entries */
 	if (skip_entries < 0) {
@@ -135,9 +132,7 @@ static int kdb_ftdump(int argc, const char **argv)
 
 	ftrace_dump_buf(skip_entries, cpu_file);
 
-	for_each_tracing_cpu(cpu) {
-		atomic_dec(&per_cpu_ptr(iter.array_buffer->data, cpu)->disabled);
-	}
+	tracer_tracing_on(iter.tr);
 
 	kdb_trap_printk--;
 
-- 
2.47.2

