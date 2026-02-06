Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02A53376A0;
	Fri,  6 Feb 2026 19:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770407936; cv=none; b=CMc5OPgnMdJImH0hldCFPAlvktZxgLL/kJcXtOYWXwPlckqXgH2rPFxQEYYVoByfLYAD9yQEOFeRZrxco9gxUkb7CmnoPzUiCcltoUrl/q5aVhZX3++OX/XfUM9vfWuH51AU14yEE13sUBjfBNShQg889JMaUwgm3BihCUp0ORQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770407936; c=relaxed/simple;
	bh=AE+4adVyJFCbyi7b/Eh27pv6ER2+eOGn0BxhQCPrptw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=rfzAg0Xg4Jq+dWpttPnOAWe6UqTD1ACFHmn/NsnzrkSIotc34ktep9bGj49YWSyptSRgxCL/xAVxl3l71jOCsaoi6RygMoxZCnSwnPA9EIM2iUULoBEG6kfVHhkkGVRiUT007aG+w8/ky8/1y+ztIBqojQCbaced0brGMA8XX5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFpecw1F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFpecw1F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD22C19425;
	Fri,  6 Feb 2026 19:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770407936;
	bh=AE+4adVyJFCbyi7b/Eh27pv6ER2+eOGn0BxhQCPrptw=;
	h=Date:From:To:Cc:Subject:References:From;
	b=UFpecw1Fy+N2l9nsd+GXJABUA+UmAUky97AYtBBXsEyIAbSDiRSJg9EnQgb6u2WQB
	 OCyl0lxOzttvrFQx1I0a1Hq6E2/hK2SYBytU4bWAPrxpTfK5y3mRx2lKjM/v3D98TG
	 PxbGzrVgLxglbJoF6m5R0/CGU34hhOwHEk/gJwwrKKt3K26HZGM6UmQODXRAlaGTIX
	 FoMYoYcrhuURqWZRppXWWz5fRJi8zEZu6kBrNapWE3GxQOHyYO/P7g0tC0PDANS4IX
	 SC+i9V2jVJGPFz80CzeCXeLbi57Kvc1KOv/BT28JiMwbZx/dqyKHQWiTRjdl3bl8hg
	 IlrDgdM8WSf/Q==
Received: from rostedt by gandalf with local (Exim 4.99.1)
	(envelope-from <rostedt@kernel.org>)
	id 1voRzL-0000000A6nk-2Y9o;
	Fri, 06 Feb 2026 14:59:35 -0500
Message-ID: <20260206195935.463072570@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 06 Feb 2026 14:37:45 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 04/12] tracing: Move ftrace_trace_stack() out of trace.c and into trace.h
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
index 42b7ad09b5d9..061c154c0618 100644
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
@@ -2966,10 +2940,10 @@ struct ftrace_stacks {
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
@@ -3052,17 +3026,6 @@ static void __ftrace_trace_stack(struct trace_array *tr,
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
index d22d761f8ebd..63260595ac8f 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -2283,6 +2283,37 @@ static inline void sanitize_event_name(char *name)
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


