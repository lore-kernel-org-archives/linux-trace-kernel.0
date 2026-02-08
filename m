Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8512741C0;
	Sun,  8 Feb 2026 03:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770521046; cv=none; b=f7/sdTy+qtCvv/vxjxpHmOTPlks5lNVOY5ZtWSpplhT0B6ZeneuF8U5n83R291gM/BwVyRwXfyPCO3ckAh1rBsbmJ2XIBcBdE6Bw2xrIEly7m/1GxF/46y075yIMXaPck7tAcV4RVANKiSAGrhnYnin5+HclN0QKsafFT5QgMe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770521046; c=relaxed/simple;
	bh=P2+u/vNHwEzn7ODM4Pi1LxTEHDnekqxDaeXdxpmwQ2o=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Kg2Tqx7mi5pHIFjzzDWf9UCeqNriCgpmIdcjanGaUAbUCpB+/x3MkgJoNcZ9A2JGirzAoJfruNgS3qDbMN+AmYUkzKqfqQyLVuL2yym7P9/1TkKlP9IdLPiovjupWYIxhJHxkH8cBk101qxXm4nmyukXIRdWgPSpQPHq0vX4hxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+VwhFqK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+VwhFqK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EE06C19424;
	Sun,  8 Feb 2026 03:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770521046;
	bh=P2+u/vNHwEzn7ODM4Pi1LxTEHDnekqxDaeXdxpmwQ2o=;
	h=Date:From:To:Cc:Subject:References:From;
	b=W+VwhFqKigWepw8h0hZv0Vs/oeE/5YfMO3/Z4Tj8St94mstZxfsZnvyNHB+Hsc1P9
	 yIMNp1Zx7w+PmbipRPYLLuJw8fJM56hHeoVRiaE/l2cvWblLnL5iKDWVCan70GcKf3
	 W8TrKKdZSCoXfuOixqpbRzv+Vx1C0gcnrh0FiCRvizxnW4qRaF5AQv9PxFBJgd9lqM
	 3hHrOV3rAHY6Ie8WviTdHwy6k/unAKQEm46xNaPjFmxmSaxE0LqqvGQ6ihLFEhDI76
	 OsP7CZrJOv1c3kNjvjO7w8FakdF72CYgA49xg4vDohgWuzJaC1Utj2zXHZ7rdgawuK
	 JfvgTiy/ppJng==
Received: from rostedt by gandalf with local (Exim 4.99.1)
	(envelope-from <rostedt@kernel.org>)
	id 1vovPl-0000000AObG-2dnE;
	Sat, 07 Feb 2026 22:24:49 -0500
Message-ID: <20260208032449.483690153@kernel.org>
User-Agent: quilt/0.68
Date: Sat, 07 Feb 2026 22:24:18 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 01/10] tracing: Make tracing_disabled global for tracing system
References: <20260208032417.262341179@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The tracing_disabled variable is set to one on boot up to prevent some
parts of tracing to access the tracing infrastructure before it is set up.
It also can be set after boot if an anomaly is discovered.

It is currently a static variable in trace.c and can be accessed via a
function call trace_is_disabled(). There's really no reason to use a
function call as the tracing subsystem should be able to access it
directly.

By making the variable accessed directly, code can be moved out of trace.c
without adding overhead of a function call to see if tracing is disabled
or not.

Make tracing_disabled global and remove the tracing_is_disabled() helper
function. Also add some "unlikely()"s around tracing_disabled where it's
checked in hot paths.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c        | 13 ++++---------
 kernel/trace/trace.h        |  3 ++-
 kernel/trace/trace_events.c |  2 +-
 kernel/trace/trace_kprobe.c |  2 +-
 4 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index d02c4004c718..1ff40c88e75c 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -114,7 +114,7 @@ DEFINE_PER_CPU(bool, trace_taskinfo_save);
  * of the tracer is successful. But that is the only place that sets
  * this back to zero.
  */
-static int tracing_disabled = 1;
+int tracing_disabled = 1;
 
 cpumask_var_t __read_mostly	tracing_buffer_mask;
 
@@ -3423,7 +3423,7 @@ int __trace_array_vprintk(struct trace_buffer *buffer,
 	unsigned int trace_ctx;
 	char *tbuffer;
 
-	if (tracing_disabled)
+	if (unlikely(tracing_disabled))
 		return 0;
 
 	/* Don't pollute graph traces with trace_vprintk internals */
@@ -4765,11 +4765,6 @@ int tracing_open_generic(struct inode *inode, struct file *filp)
 	return 0;
 }
 
-bool tracing_is_disabled(void)
-{
-	return (tracing_disabled) ? true: false;
-}
-
 /*
  * Open and update trace_array ref count.
  * Must have the current trace_array passed to it.
@@ -7609,7 +7604,7 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
 	unsigned long ip;
 	char *buf;
 
-	if (tracing_disabled)
+	if (unlikely(tracing_disabled))
 		return -EINVAL;
 
 	if (!(tr->trace_flags & TRACE_ITER(MARKERS)))
@@ -7689,7 +7684,7 @@ tracing_mark_raw_write(struct file *filp, const char __user *ubuf,
 	ssize_t written = -ENODEV;
 	char *buf;
 
-	if (tracing_disabled)
+	if (unlikely(tracing_disabled))
 		return -EINVAL;
 
 	if (!(tr->trace_flags & TRACE_ITER(MARKERS)))
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 31fb137e1c66..433705bef480 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -657,6 +657,8 @@ trace_buffer_iter(struct trace_iterator *iter, int cpu)
 	return iter->buffer_iter ? iter->buffer_iter[cpu] : NULL;
 }
 
+extern int tracing_disabled;
+
 int tracer_init(struct tracer *t, struct trace_array *tr);
 int tracing_is_enabled(void);
 void tracing_reset_online_cpus(struct array_buffer *buf);
@@ -668,7 +670,6 @@ int tracing_release_generic_tr(struct inode *inode, struct file *file);
 int tracing_open_file_tr(struct inode *inode, struct file *filp);
 int tracing_release_file_tr(struct inode *inode, struct file *filp);
 int tracing_single_release_file_tr(struct inode *inode, struct file *filp);
-bool tracing_is_disabled(void);
 bool tracer_tracing_is_on(struct trace_array *tr);
 void tracer_tracing_on(struct trace_array *tr);
 void tracer_tracing_off(struct trace_array *tr);
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index af6d1fe5cab7..61fe01dce7a6 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2268,7 +2268,7 @@ static int subsystem_open(struct inode *inode, struct file *filp)
 	struct event_subsystem *system = NULL;
 	int ret;
 
-	if (tracing_is_disabled())
+	if (unlikely(tracing_disabled))
 		return -ENODEV;
 
 	/* Make sure the system still exists */
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 89d2740f7bb5..061658518605 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -2083,7 +2083,7 @@ static __init int kprobe_trace_self_tests_init(void)
 	struct trace_kprobe *tk;
 	struct trace_event_file *file;
 
-	if (tracing_is_disabled())
+	if (unlikely(tracing_disabled))
 		return -ENODEV;
 
 	if (tracing_selftest_disabled)
-- 
2.51.0


