Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90C92BEFEB;
	Sun,  8 Feb 2026 03:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770521046; cv=none; b=m1KLvdP2783ziAGYj+sTfuZs+gHBsU04WBoN+t8+oFGXvvYt4adcOIBZcoZfTesfM7ilAGqeO3d1ARIxd8sblrcZTMJX8MWo+N6l+FWapIdafItXnabawsHdKUm2jkMV8q1mSwL7k67GDpkTL5fkroK6i7a3dWtS4FLn4h4rC4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770521046; c=relaxed/simple;
	bh=PkfKtA879ZBp3CTU0oytJ++8l4oi1boK/tfiRxrrp5c=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=lPszXiZnadM8zXJUSasDjRHUe2SkkGVFa7mW7/P1KLDCAkwn9/1RJqZVJ0K3itv9BXRBkAMSMI9rAsMr0sS1ez3ZgrCvzyl9IWVpzgKMAhYjcW43HgtdfK1uf1ehKsEJlWT90skXWzVn16xQrtAuF+6p+hk3GSjpme7l3HI9BpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rybf3fIr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rybf3fIr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A62F8C116C6;
	Sun,  8 Feb 2026 03:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770521046;
	bh=PkfKtA879ZBp3CTU0oytJ++8l4oi1boK/tfiRxrrp5c=;
	h=Date:From:To:Cc:Subject:References:From;
	b=rybf3fIryO8/8Bswj9SGvLm6yps3lXcEgpcr1Git12UwbO87U0VE7LcJ0ahn4Ej92
	 XT2SbgCOUnmRFLzVRzKSNgNzxkijJVUvMch2NRZcFHCjVNj+3qd1KvgrJz36/4v5kq
	 JRmLd6+fZZS+egIUDseSDVC6eZKB87pcGKJ2PLyfFMxi6MqUwki7Z2ZfiE7AYKONvu
	 Sax352deH+Fz+6RHGseK2U9WVrQ0gVHxeY3MQ5auFUFDPljUITI5OAr4OEKjhQoet9
	 kKlqnk/CFc/AAv98g5ka6I+A5hDAYwRTxDdH4kl20a0bjg3lpYo5XZFojHKhe2+dEW
	 Q+vwljlqp5MAA==
Received: from rostedt by gandalf with local (Exim 4.99.1)
	(envelope-from <rostedt@kernel.org>)
	id 1vovPm-0000000AOci-0W6H;
	Sat, 07 Feb 2026 22:24:50 -0500
Message-ID: <20260208032449.974218132@kernel.org>
User-Agent: quilt/0.68
Date: Sat, 07 Feb 2026 22:24:21 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 04/10] tracing: Move ftrace_trace_stack() out of trace.c and into trace.h
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

Make ftrace_trace_stack() into a static inline that tests if stack tracing
is enabled and if so to call __ftrace_trace_stack() to do the stack trace.
This keeps the test inlined in the fast paths and only does the function
call if stack tracing is enabled.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 45 ++++----------------------------------------
 kernel/trace/trace.h | 31 ++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 41 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 55cd0c774886..a515b5241391 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1032,32 +1032,6 @@ static inline void trace_access_lock_init(void)
 
 #endif
 
-#ifdef CONFIG_STACKTRACE
-static void __ftrace_trace_stack(struct trace_array *tr,
-				 struct trace_buffer *buffer,
-				 unsigned int trace_ctx,
-				 int skip, struct pt_regs *regs);
-static inline void ftrace_trace_stack(struct trace_array *tr,
-				      struct trace_buffer *buffer,
-				      unsigned int trace_ctx,
-				      int skip, struct pt_regs *regs);
-
-#else
-static inline void __ftrace_trace_stack(struct trace_array *tr,
-					struct trace_buffer *buffer,
-					unsigned int trace_ctx,
-					int skip, struct pt_regs *regs)
-{
-}
-static inline void ftrace_trace_stack(struct trace_array *tr,
-				      struct trace_buffer *buffer,
-				      unsigned long trace_ctx,
-				      int skip, struct pt_regs *regs)
-{
-}
-
-#endif
-
 void tracer_tracing_on(struct trace_array *tr)
 {
 	if (tr->array_buffer.buffer)
@@ -2964,10 +2938,10 @@ struct ftrace_stacks {
 static DEFINE_PER_CPU(struct ftrace_stacks, ftrace_stacks);
 static DEFINE_PER_CPU(int, ftrace_stack_reserve);
 
-static void __ftrace_trace_stack(struct trace_array *tr,
-				 struct trace_buffer *buffer,
-				 unsigned int trace_ctx,
-				 int skip, struct pt_regs *regs)
+void __ftrace_trace_stack(struct trace_array *tr,
+			  struct trace_buffer *buffer,
+			  unsigned int trace_ctx,
+			  int skip, struct pt_regs *regs)
 {
 	struct ring_buffer_event *event;
 	unsigned int size, nr_entries;
@@ -3050,17 +3024,6 @@ static void __ftrace_trace_stack(struct trace_array *tr,
 	trace_clear_recursion(bit);
 }
 
-static inline void ftrace_trace_stack(struct trace_array *tr,
-				      struct trace_buffer *buffer,
-				      unsigned int trace_ctx,
-				      int skip, struct pt_regs *regs)
-{
-	if (!(tr->trace_flags & TRACE_ITER(STACKTRACE)))
-		return;
-
-	__ftrace_trace_stack(tr, buffer, trace_ctx, skip, regs);
-}
-
 void __trace_stack(struct trace_array *tr, unsigned int trace_ctx,
 		   int skip)
 {
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index c2beabe96952..605ee23f3262 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -2279,6 +2279,37 @@ static inline void sanitize_event_name(char *name)
 			*name = '_';
 }
 
+#ifdef CONFIG_STACKTRACE
+void __ftrace_trace_stack(struct trace_array *tr,
+			  struct trace_buffer *buffer,
+			  unsigned int trace_ctx,
+			  int skip, struct pt_regs *regs);
+
+static __always_inline void ftrace_trace_stack(struct trace_array *tr,
+					       struct trace_buffer *buffer,
+					       unsigned int trace_ctx,
+					       int skip, struct pt_regs *regs)
+{
+	if (!(tr->trace_flags & TRACE_ITER(STACKTRACE)))
+		return;
+
+	__ftrace_trace_stack(tr, buffer, trace_ctx, skip, regs);
+}
+#else
+static inline void __ftrace_trace_stack(struct trace_array *tr,
+					struct trace_buffer *buffer,
+					unsigned int trace_ctx,
+					int skip, struct pt_regs *regs)
+{
+}
+static inline void ftrace_trace_stack(struct trace_array *tr,
+				      struct trace_buffer *buffer,
+				      unsigned long trace_ctx,
+				      int skip, struct pt_regs *regs)
+{
+}
+#endif
+
 /*
  * This is a generic way to read and write a u64 value from a file in tracefs.
  *
-- 
2.51.0


