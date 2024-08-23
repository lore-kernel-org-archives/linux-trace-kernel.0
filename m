Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F8E1C680;
	Fri, 23 Aug 2024 01:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724377187; cv=none; b=fbcpGabH86Ms+yZtk0zcSLAWZ8DJ4GtVIa8V+mkD+29RnROPTmOgvcX3GteQ/E/xgRHIO2Ca0Qb5QUU+mYKLdrt8Yz1vgSe5BKpGgHn4Vij8uu6KQsWUFyR+Xpt45SEwO0L8E1xfgx4vsrFj82IAGkbONIPRwWSGhFiJz6CtDGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724377187; c=relaxed/simple;
	bh=LTa5Q0p6734zkmNcZEFYat5XOLYbgOkYhY4a5oLezn0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=NsAiY+aoKGkEoOX6N1I71LXczD9YAwjdcPUT6x+2cigakvMMeV+Tr0FFIFxm4XiEESniyuiBo6DmX4EbfOd1LV7cNNUwN4CGcrLKLcYFQR1zdSwgXEDG5tbDNXCyd60TdbwDwVW+FoKACN78jGtjrhi2i9+cN5V0+qs+aoi0NUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A50BAC4AF13;
	Fri, 23 Aug 2024 01:39:46 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1shJHn-00000003Zi5-2CYW;
	Thu, 22 Aug 2024 21:40:19 -0400
Message-ID: <20240823014019.386925800@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 22 Aug 2024 21:39:05 -0400
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
Subject: [PATCH 3/5] tracing: Have trace_printk not use binary prints if boot buffer
References: <20240823013902.135036960@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

If the persistent boot mapped ring buffer is used for trace_printk(),
force it to not use the binary versions. trace_printk() by default uses
bin_printf() that only saves the pointer to the format and not the format
itself inside the ring buffer. But for a persistent buffer that is read
after reboot, the pointers to the format strings may not be the same, or
worse, not even exist! Instead, just force the more robust, but slower,
version that does the formatting before saving into the ring buffer.

The boot mapped buffer can now be used for trace_printk and friends!

Using the trace_printk() and the persistent buffer was used to debug the
issue with the osnoise tracer:

Link: https://lore.kernel.org/all/20240822103443.6a6ae051@gandalf.local.home/

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 .../admin-guide/kernel-parameters.txt         |  4 +-
 kernel/trace/trace.c                          | 44 ++++++++++++-------
 kernel/trace/trace.h                          |  3 +-
 kernel/trace/trace_output.c                   |  5 ++-
 4 files changed, 36 insertions(+), 20 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a8803c0c0a89..9e507e6cb4c8 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6751,8 +6751,6 @@
 			    traceoff	- Have the tracing instance tracing disabled after it is created.
 			    traceprintk	- Have trace_printk() write into this trace instance
 					  (note, "printk" and "trace_printk" can also be used)
-					  Currently, traceprintk flag cannot be used for memory
-					  mapped ring buffers as described below.
 
 				trace_instance=foo^traceoff^traceprintk,sched,irq
 
@@ -6785,7 +6783,7 @@
 			mix with events of the current boot (unless you are debugging a random crash
 			at boot up).
 
-				reserve_mem=12M:4096:trace trace_instance=boot_map^traceoff@trace,sched,irq
+				reserve_mem=12M:4096:trace trace_instance=boot_map^traceoff^traceprintk@trace,sched,irq
 
 
 	trace_options=[option-list]
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 8e28f19f5316..35b37c9aa26c 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -502,6 +502,17 @@ static struct trace_array global_trace = {
 
 static struct trace_array *printk_trace = &global_trace;
 
+static __always_inline bool printk_binsafe(struct trace_array *tr)
+{
+	/*
+	 * The binary format of traceprintk can cause a crash if used
+	 * by a buffer from another boot. Force the use of the
+	 * non binary version of trace_printk if the trace_printk
+	 * buffer is a boot mapped ring buffer.
+	 */
+	return !(tr->flags & TRACE_ARRAY_FL_BOOT);
+}
+
 void trace_set_ring_buffer_expanded(struct trace_array *tr)
 {
 	if (!tr)
@@ -1130,7 +1141,7 @@ EXPORT_SYMBOL_GPL(__trace_puts);
  */
 int __trace_bputs(unsigned long ip, const char *str)
 {
-	struct trace_array *tr = printk_trace;
+	struct trace_array *tr = READ_ONCE(printk_trace);
 	struct ring_buffer_event *event;
 	struct trace_buffer *buffer;
 	struct bputs_entry *entry;
@@ -1138,6 +1149,9 @@ int __trace_bputs(unsigned long ip, const char *str)
 	int size = sizeof(struct bputs_entry);
 	int ret = 0;
 
+	if (!printk_binsafe(tr))
+		return __trace_puts(ip, str, strlen(str));
+
 	if (!(tr->trace_flags & TRACE_ITER_PRINTK))
 		return 0;
 
@@ -3247,12 +3261,15 @@ int trace_vbprintk(unsigned long ip, const char *fmt, va_list args)
 	struct trace_event_call *call = &event_bprint;
 	struct ring_buffer_event *event;
 	struct trace_buffer *buffer;
-	struct trace_array *tr = printk_trace;
+	struct trace_array *tr = READ_ONCE(printk_trace);
 	struct bprint_entry *entry;
 	unsigned int trace_ctx;
 	char *tbuffer;
 	int len = 0, size;
 
+	if (!printk_binsafe(tr))
+		return trace_vprintk(ip, fmt, args);
+
 	if (unlikely(tracing_selftest_running || tracing_disabled))
 		return 0;
 
@@ -10560,20 +10577,17 @@ __init static void enable_instances(void)
 		if (traceoff)
 			tracer_tracing_off(tr);
 
-		if (traceprintk) {
-			/*
-			 * The binary format of traceprintk can cause a crash if used
-			 * by a buffer from another boot. Do not allow it for the
-			 * memory mapped ring buffers.
-			 */
-			if (start)
-				pr_warn("Tracing: WARNING: memory mapped ring buffers cannot be used for trace_printk\n");
-			else
-				printk_trace = tr;
-		}
+		if (traceprintk)
+			printk_trace = tr;
 
-		/* Only allow non mapped buffers to be deleted */
-		if (!start)
+		/*
+		 * If start is set, then this is a mapped buffer, and
+		 * cannot be deleted by user space, so keep the reference
+		 * to it.
+		 */
+		if (start)
+			tr->flags |= TRACE_ARRAY_FL_BOOT;
+		else
 			trace_array_put(tr);
 
 		while ((tok = strsep(&curr_str, ","))) {
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 4f448ab2d1e7..07b2d2af9b33 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -429,7 +429,8 @@ struct trace_array {
 };
 
 enum {
-	TRACE_ARRAY_FL_GLOBAL	= (1 << 0)
+	TRACE_ARRAY_FL_GLOBAL	= BIT(0),
+	TRACE_ARRAY_FL_BOOT	= BIT(1),
 };
 
 extern struct list_head ftrace_trace_arrays;
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 48de93598897..868f2f912f28 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -1591,10 +1591,13 @@ static enum print_line_t trace_print_print(struct trace_iterator *iter,
 {
 	struct print_entry *field;
 	struct trace_seq *s = &iter->seq;
+	unsigned long ip;
 
 	trace_assign_type(field, iter->ent);
 
-	seq_print_ip_sym(s, field->ip, flags);
+	ip = field->ip + iter->tr->text_delta;
+
+	seq_print_ip_sym(s, ip, flags);
 	trace_seq_printf(s, ": %s", field->buf);
 
 	return trace_handle_return(s);
-- 
2.43.0


