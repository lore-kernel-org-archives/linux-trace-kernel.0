Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560BA2D0600;
	Sun,  8 Feb 2026 03:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770521047; cv=none; b=lQAUyPpPgBzdvt2/rM/EOeoN5jzZ4nMkS76eHCmZHEmSuTwHV1325Lg1zsd5UVUn39qjTqCpSTsZizFBZhe1vf03WKRTnXryZjFyoXBf4OSn9KW1PsSBtVBOOWyuJL5xM3PgfK9DmzMMTKYKbQ4iNvydhSqhNOxhM9kg45IiONc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770521047; c=relaxed/simple;
	bh=i8degb57vUuiSHEjbklu1wiQSbWaGQjUxuSzZzW7ZMo=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ZdqXlfEo5Yt/ghM71wd1BoDlERfjSonVieubnpZIkZ84gx+71Vm8yvPx46oSaijsmPVAmybqQvDQOx/GrA0MNicnFNrMU7ZwTbJ8ItYinxzLJFp744rrYRtiYb5rOd8c/++5I9KAF/BjzOEY9J7fiH6pieFYf4NCqo0B+FW1eKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FiE81IZT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FiE81IZT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3051AC2BC87;
	Sun,  8 Feb 2026 03:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770521047;
	bh=i8degb57vUuiSHEjbklu1wiQSbWaGQjUxuSzZzW7ZMo=;
	h=Date:From:To:Cc:Subject:References:From;
	b=FiE81IZTR9yzLZcu8h/690/PxxI2CfHBy5u2OZREKOsBLbyV16zX469440jhQWb7A
	 zhOM1NDClqvuwDjsuCDJzQ2XMreGpUeZbZdZ4vn8zQTmQw5A8UgdAGUTR3DUqA69ef
	 H/6QriT55XprrecyDVGGKbPuiHgXwGt5m6fy3NorP3ASwA8WbOCLNE5kCZ9Ph3E0Cn
	 Dz3q4mJuYP2V1DUoC7mzWeCEf9vmMfloIvfolrqiHRG8WYJ/CGmH2N6xSChiLV+6ZT
	 T5ZY6JoFPp7H+VJLqa+KCoulCim79y//rMyFcp5dxKIaRq8dUrEZPyA6A404JSTaqx
	 ITdf+gxpTn/fw==
Received: from rostedt by gandalf with local (Exim 4.99.1)
	(envelope-from <rostedt@kernel.org>)
	id 1vovPm-0000000AOeA-2gO1;
	Sat, 07 Feb 2026 22:24:50 -0500
Message-ID: <20260208032450.491116245@kernel.org>
User-Agent: quilt/0.68
Date: Sat, 07 Feb 2026 22:24:24 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 07/10] tracing: Have trace_printk functions use flags instead of using
 global_trace
References: <20260208032417.262341179@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The trace.c file has become a dumping ground for all tracing code and has
become quite large. In order to move the trace_printk functions out of it
these functions can not access global_trace directly, as that is something
that needs to stay static in trace.c.

Instead of testing the trace_array tr pointer to &global_trace, test the
tr->flags to see if TRACE_ARRAY_FL_GLOBAL set.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 601b6f622391..f4ae80564615 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1071,7 +1071,8 @@ int __trace_array_puts(struct trace_array *tr, unsigned long ip,
 	if (!(tr->trace_flags & TRACE_ITER(PRINTK)))
 		return 0;
 
-	if (unlikely(tracing_selftest_running && tr == &global_trace))
+	if (unlikely(tracing_selftest_running &&
+		     (tr->flags & TRACE_ARRAY_FL_GLOBAL)))
 		return 0;
 
 	if (unlikely(tracing_disabled))
@@ -3386,7 +3387,7 @@ int __trace_array_vprintk(struct trace_buffer *buffer,
 int trace_array_vprintk(struct trace_array *tr,
 			unsigned long ip, const char *fmt, va_list args)
 {
-	if (tracing_selftest_running && tr == &global_trace)
+	if (tracing_selftest_running && (tr->flags & TRACE_ARRAY_FL_GLOBAL))
 		return 0;
 
 	return __trace_array_vprintk(tr->array_buffer.buffer, ip, fmt, args);
@@ -3422,7 +3423,7 @@ int trace_array_printk(struct trace_array *tr,
 		return -ENOENT;
 
 	/* This is only allowed for created instances */
-	if (tr == &global_trace)
+	if (tr->flags & TRACE_ARRAY_FL_GLOBAL)
 		return 0;
 
 	if (!(tr->trace_flags & TRACE_ITER(PRINTK)))
@@ -3449,7 +3450,7 @@ int trace_array_init_printk(struct trace_array *tr)
 		return -ENOENT;
 
 	/* This is only allowed for created instances */
-	if (tr == &global_trace)
+	if (tr->flags & TRACE_ARRAY_FL_GLOBAL)
 		return -EINVAL;
 
 	return alloc_percpu_trace_buffer();
-- 
2.51.0


