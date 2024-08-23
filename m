Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB77B66F;
	Fri, 23 Aug 2024 01:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724377186; cv=none; b=Xz/omyouHprCrO6XuCSfrf7geAU5Q2BLteN2ILvmAdWUu7/hOeN2FklOhBQHLkVDo4axPHwkHSJhN60AOGj2KzAXtfDcSjKPFhX/BoxojHRtfi/XgGff708WSY6go10MoG8DCDvG/nk3UAbW0Yj70uT25mrSfL7relPE8aTh1D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724377186; c=relaxed/simple;
	bh=/d1bvxifrbkSDTMaZcbI1ILGIbF1ysjIACrWH57QwDI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=IxSacUb2JRlDZdNIRw1Af9iIeGdkRwVn4TSuw01CC5FUyXkzIoB5wgrC2YjXp8yMTjSjSLiCSG6bJ59vRk9mwoWdgyploSN3b0rJfaAgBf0aQw40dg2rH0rDWoHBnEhCsKu4dKGX+4aFTOIfy4kq9PbuMVFeXztTHUFe9QuWROs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8058DC4AF10;
	Fri, 23 Aug 2024 01:39:46 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1shJHn-00000003Zhb-1Xf5;
	Thu, 22 Aug 2024 21:40:19 -0400
Message-ID: <20240823014019.226694946@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 22 Aug 2024 21:39:04 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vincent Donnefort <vdonnefort@google.com>,
 Joel Fernandes <joel@joelfernandes.org>,
 Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 suleiman@google.com,
 Thomas Gleixner <tglx@linutronix.de>,
 Vineeth Pillai <vineeth@bitbyteword.org>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 Alexander Graf <graf@amazon.com>,
 Baoquan He <bhe@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 David Howells <dhowells@redhat.com>,
 Mike Rapoport <rppt@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Tony Luck <tony.luck@intel.com>,
 Guenter Roeck <linux@roeck-us.net>,
 Ross Zwisler <zwisler@google.com>,
 Kees Cook <keescook@chromium.org>,
 Alexander Aring <aahringo@redhat.com>,
 "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
 Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Clark Williams <williams@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "Jonathan Corbet" <corbet@lwn.net>
Subject: [PATCH 2/5] tracing: Allow trace_printk() to go to other instance buffers
References: <20240823013902.135036960@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Currently, trace_printk() just goes to the top level ring buffer. But
there may be times that it should go to one of the instances created by
the kernel command line.

Add a new trace_instance flag: traceprintk (also can use "printk" or
"trace_printk" as people tend to forget the actual flag name).

  trace_instance=foo^traceprintk

Will assign the trace_printk to this buffer at boot up.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 .../admin-guide/kernel-parameters.txt         | 14 ++++--
 kernel/trace/trace.c                          | 46 ++++++++++++++-----
 2 files changed, 45 insertions(+), 15 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 3803f2b7f065..a8803c0c0a89 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6744,11 +6744,17 @@
 			event, and all events under the "initcall" system.
 
 			Flags can be added to the instance to modify its behavior when it is
-			created. The flags are separated by '^'. Currently there's only one flag
-			defined, and that's "traceoff", to have the tracing instance tracing
-			disabled after it is created.
+			created. The flags are separated by '^'.
 
-				trace_instance=foo^traceoff,sched,irq
+			The available flags are:
+
+			    traceoff	- Have the tracing instance tracing disabled after it is created.
+			    traceprintk	- Have trace_printk() write into this trace instance
+					  (note, "printk" and "trace_printk" can also be used)
+					  Currently, traceprintk flag cannot be used for memory
+					  mapped ring buffers as described below.
+
+				trace_instance=foo^traceoff^traceprintk,sched,irq
 
 			The flags must come before the defined events.
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index a79eefe84d6b..8e28f19f5316 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -500,6 +500,8 @@ static struct trace_array global_trace = {
 	.trace_flags = TRACE_DEFAULT_FLAGS,
 };
 
+static struct trace_array *printk_trace = &global_trace;
+
 void trace_set_ring_buffer_expanded(struct trace_array *tr)
 {
 	if (!tr)
@@ -1117,7 +1119,7 @@ EXPORT_SYMBOL_GPL(__trace_array_puts);
  */
 int __trace_puts(unsigned long ip, const char *str, int size)
 {
-	return __trace_array_puts(&global_trace, ip, str, size);
+	return __trace_array_puts(printk_trace, ip, str, size);
 }
 EXPORT_SYMBOL_GPL(__trace_puts);
 
@@ -1128,6 +1130,7 @@ EXPORT_SYMBOL_GPL(__trace_puts);
  */
 int __trace_bputs(unsigned long ip, const char *str)
 {
+	struct trace_array *tr = printk_trace;
 	struct ring_buffer_event *event;
 	struct trace_buffer *buffer;
 	struct bputs_entry *entry;
@@ -1135,14 +1138,14 @@ int __trace_bputs(unsigned long ip, const char *str)
 	int size = sizeof(struct bputs_entry);
 	int ret = 0;
 
-	if (!(global_trace.trace_flags & TRACE_ITER_PRINTK))
+	if (!(tr->trace_flags & TRACE_ITER_PRINTK))
 		return 0;
 
 	if (unlikely(tracing_selftest_running || tracing_disabled))
 		return 0;
 
 	trace_ctx = tracing_gen_ctx();
-	buffer = global_trace.array_buffer.buffer;
+	buffer = tr->array_buffer.buffer;
 
 	ring_buffer_nest_start(buffer);
 	event = __trace_buffer_lock_reserve(buffer, TRACE_BPUTS, size,
@@ -1155,7 +1158,7 @@ int __trace_bputs(unsigned long ip, const char *str)
 	entry->str			= str;
 
 	__buffer_unlock_commit(buffer, event);
-	ftrace_trace_stack(&global_trace, buffer, trace_ctx, 4, NULL);
+	ftrace_trace_stack(tr, buffer, trace_ctx, 4, NULL);
 
 	ret = 1;
  out:
@@ -3025,7 +3028,7 @@ void trace_dump_stack(int skip)
 	/* Skip 1 to skip this function. */
 	skip++;
 #endif
-	__ftrace_trace_stack(global_trace.array_buffer.buffer,
+	__ftrace_trace_stack(printk_trace->array_buffer.buffer,
 			     tracing_gen_ctx(), skip, NULL);
 }
 EXPORT_SYMBOL_GPL(trace_dump_stack);
@@ -3244,7 +3247,7 @@ int trace_vbprintk(unsigned long ip, const char *fmt, va_list args)
 	struct trace_event_call *call = &event_bprint;
 	struct ring_buffer_event *event;
 	struct trace_buffer *buffer;
-	struct trace_array *tr = &global_trace;
+	struct trace_array *tr = printk_trace;
 	struct bprint_entry *entry;
 	unsigned int trace_ctx;
 	char *tbuffer;
@@ -3342,7 +3345,7 @@ __trace_array_vprintk(struct trace_buffer *buffer,
 	memcpy(&entry->buf, tbuffer, len + 1);
 	if (!call_filter_check_discard(call, entry, buffer, event)) {
 		__buffer_unlock_commit(buffer, event);
-		ftrace_trace_stack(&global_trace, buffer, trace_ctx, 6, NULL);
+		ftrace_trace_stack(printk_trace, buffer, trace_ctx, 6, NULL);
 	}
 
 out:
@@ -3438,7 +3441,7 @@ int trace_array_printk_buf(struct trace_buffer *buffer,
 	int ret;
 	va_list ap;
 
-	if (!(global_trace.trace_flags & TRACE_ITER_PRINTK))
+	if (!(printk_trace->trace_flags & TRACE_ITER_PRINTK))
 		return 0;
 
 	va_start(ap, fmt);
@@ -3450,7 +3453,7 @@ int trace_array_printk_buf(struct trace_buffer *buffer,
 __printf(2, 0)
 int trace_vprintk(unsigned long ip, const char *fmt, va_list args)
 {
-	return trace_array_vprintk(&global_trace, ip, fmt, args);
+	return trace_array_vprintk(printk_trace, ip, fmt, args);
 }
 EXPORT_SYMBOL_GPL(trace_vprintk);
 
@@ -9666,6 +9669,9 @@ static int __remove_instance(struct trace_array *tr)
 			set_tracer_flag(tr, 1 << i, 0);
 	}
 
+	if (printk_trace == tr)
+		printk_trace = &global_trace;
+
 	tracing_set_nop(tr);
 	clear_ftrace_function_probes(tr);
 	event_trace_del_tracer(tr);
@@ -10468,6 +10474,7 @@ __init static void enable_instances(void)
 		phys_addr_t start = 0;
 		phys_addr_t size = 0;
 		unsigned long addr = 0;
+		bool traceprintk = false;
 		bool traceoff = false;
 		char *flag_delim;
 		char *addr_delim;
@@ -10489,11 +10496,16 @@ __init static void enable_instances(void)
 			char *flag;
 
 			while ((flag = strsep(&flag_delim, "^"))) {
-				if (strcmp(flag, "traceoff") == 0)
+				if (strcmp(flag, "traceoff") == 0) {
 					traceoff = true;
-				else
+				} else if ((strcmp(flag, "printk") == 0) ||
+					   (strcmp(flag, "traceprintk") == 0) ||
+					   (strcmp(flag, "trace_printk") == 0)) {
+					traceprintk = true;
+				} else {
 					pr_info("Tracing: Invalid instance flag '%s' for %s\n",
 						flag, name);
+				}
 			}
 		}
 
@@ -10548,6 +10560,18 @@ __init static void enable_instances(void)
 		if (traceoff)
 			tracer_tracing_off(tr);
 
+		if (traceprintk) {
+			/*
+			 * The binary format of traceprintk can cause a crash if used
+			 * by a buffer from another boot. Do not allow it for the
+			 * memory mapped ring buffers.
+			 */
+			if (start)
+				pr_warn("Tracing: WARNING: memory mapped ring buffers cannot be used for trace_printk\n");
+			else
+				printk_trace = tr;
+		}
+
 		/* Only allow non mapped buffers to be deleted */
 		if (!start)
 			trace_array_put(tr);
-- 
2.43.0


