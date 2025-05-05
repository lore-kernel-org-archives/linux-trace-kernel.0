Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22672741C0;
	Mon,  5 May 2025 21:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746480148; cv=none; b=VQeC5CdfOydLaMNvLCQPTYHyOXJlvqA/r9d7/1Yjr02fx2O+o++FBOUuRorBkQTXPMTbTGfCkR8g/9nsPPrKSALGa9d2ILsNGojlxFpQplFaX7qDsbi05HfuBVx9TC5aLopMa6rdjRg5NSUPDydinOaq/8XFklGgn+3DBy2RTZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746480148; c=relaxed/simple;
	bh=AtbwyqvdErRJG3wewcNLOmRcFKegEF41KY1o+ID/ICI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=cUbh03uUw9pczeWZ9u1P5UaolnOX6+U5oho6tCdUjwfxbcH1GyHxsWkI5IWX0git0ezuMAnIr+7S8hoN1wOI3YMW7XYEQx/khaZSn5hECdOKfRB/M4R6FMsHUqJ8jIgmVsexvSneBS4xPGEVJtVOZKT8CF2qDcLZtSaDjgwWYWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E7DC4CEF5;
	Mon,  5 May 2025 21:22:28 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uC3Gl-00000000yCj-1VSq;
	Mon, 05 May 2025 17:22:35 -0400
Message-ID: <20250505212235.210330010@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 05 May 2025 17:21:08 -0400
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
Subject: [PATCH v2 04/13] tracing: Add tracer_tracing_disable/enable() functions
References: <20250505212104.986494754@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Allow a tracer to disable writing to its buffer for a temporary amount of
time and re-enable it.

The tracer_tracing_disable() will disable writing to the trace array
buffer, and requires a tracer_tracing_enable() to re-enable it.

The difference between tracer_tracing_disable() and tracer_tracing_off()
is that the disable version can nest, and requires as many enable() calls
as disable() calls to re-enable the buffer. Where as the off() function
can be called multiple times and only requires a singe tracer_tracing_on()
to re-enable the buffer.

Cc: Jason Wessel <jason.wessel@windriver.com>
Cc: Daniel Thompson <danielt@kernel.org>
Cc: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 33 +++++++++++++++++++++++++++++++++
 kernel/trace/trace.h |  2 ++
 2 files changed, 35 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 5b8db27fb6ef..e36b1244fa82 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1582,6 +1582,39 @@ void tracer_tracing_off(struct trace_array *tr)
 	smp_wmb();
 }
 
+/**
+ * tracer_tracing_disable() - temporary disable the buffer from write
+ * @tr: The trace array to disable its buffer for
+ *
+ * Expects trace_tracing_enable() to re-enable tracing.
+ * The difference between this and tracer_tracing_off() is that this
+ * is a counter and can nest, whereas, tracer_tracing_off() can
+ * be called multiple times and a single trace_tracing_on() will
+ * enable it.
+ */
+void tracer_tracing_disable(struct trace_array *tr)
+{
+	if (WARN_ON_ONCE(!tr->array_buffer.buffer))
+		return;
+
+	ring_buffer_record_disable(tr->array_buffer.buffer);
+}
+
+/**
+ * tracer_tracing_enable() - counter part of tracer_tracing_disable()
+ * @tr: The trace array that had tracer_tracincg_disable() called on it
+ *
+ * This is called after tracer_tracing_disable() has been called on @tr,
+ * when it's safe to re-enable tracing.
+ */
+void tracer_tracing_enable(struct trace_array *tr)
+{
+	if (WARN_ON_ONCE(!tr->array_buffer.buffer))
+		return;
+
+	ring_buffer_record_enable(tr->array_buffer.buffer);
+}
+
 /**
  * tracing_off - turn off tracing buffers
  *
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 79be1995db44..74f1fe5788d4 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -665,6 +665,8 @@ bool tracing_is_disabled(void);
 bool tracer_tracing_is_on(struct trace_array *tr);
 void tracer_tracing_on(struct trace_array *tr);
 void tracer_tracing_off(struct trace_array *tr);
+void tracer_tracing_disable(struct trace_array *tr);
+void tracer_tracing_enable(struct trace_array *tr);
 struct dentry *trace_create_file(const char *name,
 				 umode_t mode,
 				 struct dentry *parent,
-- 
2.47.2


