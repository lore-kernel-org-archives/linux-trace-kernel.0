Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777C632AAAE;
	Fri,  6 Feb 2026 19:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770407936; cv=none; b=mmR9eHpTxLXniqwpQYW+sPsGMyYaBL3HdJjBB9Ff8QP2OKbCRR9NLyilnnLw+t0xJPkLAjBJ8K00KmHrdMKkb/cWA3+V+ZeVz/pE7VD1aDgN76GcbXPVLiQdCJe6jqqDzaxOUuugePyp322hpbclzea3kSLCbQWYyjiMK1Zs9V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770407936; c=relaxed/simple;
	bh=hc6PrYVuC/Wg7y0SBTDSMwFVfst74rco+Jjkpoa75B8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=GHsWzhqV6y+92RDkKsh7yy1+pBapBdrRqGmwEbEfSzNOlbOh/BrlNrQ6cYsiXq0EzMZsEOSatXSQ570Na55xKFvBKV43Qpi+FBd5ZwhQarvcfUcZjoX21KCb5XOLj5+l3ElMRMR7q5ow/UcEKG3svYf2Fg8bcKU9aHJu6g6CzS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nf1ybEIy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nf1ybEIy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 558A9C2BC87;
	Fri,  6 Feb 2026 19:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770407936;
	bh=hc6PrYVuC/Wg7y0SBTDSMwFVfst74rco+Jjkpoa75B8=;
	h=Date:From:To:Cc:Subject:References:From;
	b=nf1ybEIyyxUzuUwoIrdbgZuv6Xo0HSvILPv9cc1jDgg+qPnVgiuZaMcEfaJsv5C4J
	 YKp6cgeiNoBkr4r9X6Zen0bE1ZHPJjj41JRQDBjq8wFYKasXuHAv0nziykfxdZFKHH
	 /8pRd9bVIFH8U6RtxeabTD0S7h9KmjpIoJyXKWtskw8xgjrBXq4cYcuCb1whxGxkhE
	 syT5z5KGleteIVyC6lr88Oq1lx7MZrmmoizec9vSGiq7oaR9xNAhnO3o/rA9P5apqY
	 lbmZHYNcrRHV1WPYSdlX2+O0X5KDRdkKIAYUzOD1dLlPb9DO1EsA7Aqj6PSjipreqY
	 xEtwZe3F+EaQw==
Received: from rostedt by gandalf with local (Exim 4.99.1)
	(envelope-from <rostedt@kernel.org>)
	id 1voRzL-0000000A6nG-1poz;
	Fri, 06 Feb 2026 14:59:35 -0500
Message-ID: <20260206195935.293094674@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 06 Feb 2026 14:37:44 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 03/12] tracing: Move __trace_buffer_{un}lock_*() functions to trace.h
References: <20260206193741.767171392@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The file trace.c has become a catchall for most things tracing. Start
making it smaller by breaking out various aspects into their own files.

Move the __always_inline functions __trace_buffer_lock_reserve(),
__trace_buffer_unlock_commit() and trace_event_setup() into trace.h.

The trace.c file will be split up and these functions will be used in more
than one of these files. As they are already __always_inline they can
easily be moved into the trace.h header file.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 42 ------------------------------------------
 kernel/trace/trace.h | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 42 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index dafcdd31570b..42b7ad09b5d9 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1058,30 +1058,6 @@ static inline void ftrace_trace_stack(struct trace_array *tr,
 
 #endif
 
-static __always_inline void
-trace_event_setup(struct ring_buffer_event *event,
-		  int type, unsigned int trace_ctx)
-{
-	struct trace_entry *ent = ring_buffer_event_data(event);
-
-	tracing_generic_entry_update(ent, type, trace_ctx);
-}
-
-static __always_inline struct ring_buffer_event *
-__trace_buffer_lock_reserve(struct trace_buffer *buffer,
-			  int type,
-			  unsigned long len,
-			  unsigned int trace_ctx)
-{
-	struct ring_buffer_event *event;
-
-	event = ring_buffer_lock_reserve(buffer, len);
-	if (event != NULL)
-		trace_event_setup(event, type, trace_ctx);
-
-	return event;
-}
-
 void tracer_tracing_on(struct trace_array *tr)
 {
 	if (tr->array_buffer.buffer)
@@ -1109,24 +1085,6 @@ void tracing_on(void)
 }
 EXPORT_SYMBOL_GPL(tracing_on);
 
-
-static __always_inline void
-__buffer_unlock_commit(struct trace_buffer *buffer, struct ring_buffer_event *event)
-{
-	__this_cpu_write(trace_taskinfo_save, true);
-
-	/* If this is the temp buffer, we need to commit fully */
-	if (this_cpu_read(trace_buffered_event) == event) {
-		/* Length is in event->array[0] */
-		ring_buffer_write(buffer, event->array[0], &event->array[1]);
-		/* Release the temp buffer */
-		this_cpu_dec(trace_buffered_event_cnt);
-		/* ring_buffer_unlock_commit() enables preemption */
-		preempt_enable_notrace();
-	} else
-		ring_buffer_unlock_commit(buffer);
-}
-
 int __trace_array_puts(struct trace_array *tr, unsigned long ip,
 		       const char *str, int size)
 {
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index ccfaa9b4d2bf..d22d761f8ebd 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1572,6 +1572,47 @@ char *trace_user_fault_read(struct trace_user_buf_info *tinfo,
 			    const char __user *ptr, size_t size,
 			    trace_user_buf_copy copy_func, void *data);
 
+static __always_inline void
+trace_event_setup(struct ring_buffer_event *event,
+		  int type, unsigned int trace_ctx)
+{
+	struct trace_entry *ent = ring_buffer_event_data(event);
+
+	tracing_generic_entry_update(ent, type, trace_ctx);
+}
+
+static __always_inline struct ring_buffer_event *
+__trace_buffer_lock_reserve(struct trace_buffer *buffer,
+			  int type,
+			  unsigned long len,
+			  unsigned int trace_ctx)
+{
+	struct ring_buffer_event *event;
+
+	event = ring_buffer_lock_reserve(buffer, len);
+	if (event != NULL)
+		trace_event_setup(event, type, trace_ctx);
+
+	return event;
+}
+
+static __always_inline void
+__buffer_unlock_commit(struct trace_buffer *buffer, struct ring_buffer_event *event)
+{
+	__this_cpu_write(trace_taskinfo_save, true);
+
+	/* If this is the temp buffer, we need to commit fully */
+	if (this_cpu_read(trace_buffered_event) == event) {
+		/* Length is in event->array[0] */
+		ring_buffer_write(buffer, event->array[0], &event->array[1]);
+		/* Release the temp buffer */
+		this_cpu_dec(trace_buffered_event_cnt);
+		/* ring_buffer_unlock_commit() enables preemption */
+		preempt_enable_notrace();
+	} else
+		ring_buffer_unlock_commit(buffer);
+}
+
 static inline void
 __trace_event_discard_commit(struct trace_buffer *buffer,
 			     struct ring_buffer_event *event)
-- 
2.51.0


