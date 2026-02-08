Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB94F293C4E;
	Sun,  8 Feb 2026 03:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770521046; cv=none; b=suzgKSH4PDCizj6Y/nmg2PWDSX0C/1Om4IirMpLwWv8wj67NdJ2y/s22gADkP8bQEkKGymPKcmfjJGNfjIRKRm6GFfRB1FZeg1ASYazqUTNbWr0zbfuIiB2eYBF+fHMHqdcFTC4wPLoBQdVngE6SNjXOjcnGgx9p8lgukUkP3ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770521046; c=relaxed/simple;
	bh=Ss/0hHnK8DPO0iCJwrIIKNzPNkD50min9pGCh2rRKFc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=izkTqeBnyY/qKn/v1kLDXwQkFBrZZNYbn4284U3eAFPZOc78T897QGk0/PwM0HzglB/RsoiMZwCGn8O9Y1jerR9y5vkR6VNpZVztYO366l5gJgSJayP6Qc7QUpAakIsVd8RKTIDSzp20r1u4sheYzCt/jD8rjvhze2mqjafBv0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QJpV1PcN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJpV1PcN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 991B6C2BC9E;
	Sun,  8 Feb 2026 03:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770521046;
	bh=Ss/0hHnK8DPO0iCJwrIIKNzPNkD50min9pGCh2rRKFc=;
	h=Date:From:To:Cc:Subject:References:From;
	b=QJpV1PcNp7cJZ7SKHk+kw3T7AUcxzikb5uVfE6buEUUs1yL7C4Hr+2bcGBaCIhihV
	 OPKN22zKd9ugsp5ZSIwdXN/O/LE9ClpbMhnoyrA4ELGcpCVvuHljmw9WXidrmoCJbd
	 fANaUGkKTE7K/06DI/A7E6JKL+CtVoLkKvfuAKRBgUwixwOPSUo/EXBp2+kM/eb/oK
	 R+LGeulE7Hm5WcII51QxC2LXQKa4W1kpq2R3TTrhANHcYuPel3adI+hE4uvWPEoz1z
	 0VmRwOxH085BUQaWExw5j9qjyUufLJ+WgKOTxluP5BdZOYKCB02ndsAKLQ+JhZEO3s
	 8Zpnr0zi+aVhQ==
Received: from rostedt by gandalf with local (Exim 4.99.1)
	(envelope-from <rostedt@kernel.org>)
	id 1vovPl-0000000AOcE-415G;
	Sat, 07 Feb 2026 22:24:49 -0500
Message-ID: <20260208032449.813550600@kernel.org>
User-Agent: quilt/0.68
Date: Sat, 07 Feb 2026 22:24:20 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 03/10] tracing: Move __trace_buffer_{un}lock_*() functions to trace.h
References: <20260208032417.262341179@kernel.org>
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
index f040ee4fe101..55cd0c774886 100644
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
index 19cffc7b5852..c2beabe96952 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1568,6 +1568,47 @@ char *trace_user_fault_read(struct trace_user_buf_info *tinfo,
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


