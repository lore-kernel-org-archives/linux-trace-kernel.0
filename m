Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1546A33A01E;
	Fri,  6 Feb 2026 19:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770407937; cv=none; b=lsjggLYrJpaHmzPoM08zAW0jabV+Z81gkS7RmcKZyYwCf5CeO7zGEeiznllVDVMLFXH7l/8bOL8+8oHSD/qgMpiKFWFrhVzLu2rGoDzl6FAVRhxLeVjk+g1G+A+6R1xf3b54u1QNU7lBWnvIXijxfaSTq9xlXMXHcOCNQ1ZSqgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770407937; c=relaxed/simple;
	bh=SYZ1Rq8DSyU94U+FTXKwm9x7vluarbRusnyLeVZ0CUY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=LisjGLNbsw9/Wdo7slthkP8oWZbfIErpXrezrAPUacCvynWxfGLRvDtqVad/fRoRWLN1bCXAdf8Cu/kVzNo/U+5Sx8Zdq/H2yu31q4trvpIjzfzeP4Iosoyv/0LD4G2yjOClskrX6ZhUgN+baQUeH77aXA8oPuuv3z4q+I6GS6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q1T1D5vh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q1T1D5vh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A7DC2BCB3;
	Fri,  6 Feb 2026 19:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770407936;
	bh=SYZ1Rq8DSyU94U+FTXKwm9x7vluarbRusnyLeVZ0CUY=;
	h=Date:From:To:Cc:Subject:References:From;
	b=q1T1D5vh0Rv65qzVNnYrU9hbK4faB8CHLdRlemizd6XrVCWwRorCR8BaeOC06PWoY
	 3lrVSwv5F/VHc5VPIKO0PTdma6X2yxuOUmdO2hsNR8KU6QNAZdyHDruxgCL3KwmvaY
	 mReUaovtbUkh/Ujzy2MGOc8wDyDhXMAjmmkio0Jz22z50FqBu9zxRbf0OvF864oc26
	 2QINTkkHB87DMgNXBWhDSzftyoibfy8bAbtwWt+DXd4GXWwm2pnlyeapChAX39fQMF
	 Hvh0RJSPal7RBf3uYDtcrkN0vBKi7zQBJp2Bzl4ABwa338L5GDu0D505RZJA98Xgr4
	 WJQ8qfNfarD7A==
Received: from rostedt by gandalf with local (Exim 4.99.1)
	(envelope-from <rostedt@kernel.org>)
	id 1voRzM-0000000A6pC-0Pgu;
	Fri, 06 Feb 2026 14:59:36 -0500
Message-ID: <20260206195935.952012814@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 06 Feb 2026 14:37:48 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 07/12] tracing: Have trace_printk functions use flags instead of using
 global_trace
References: <20260206193741.767171392@kernel.org>
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
index a68948ac8bf9..db36d4aebc15 100644
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
@@ -3388,7 +3389,7 @@ int __trace_array_vprintk(struct trace_buffer *buffer,
 int trace_array_vprintk(struct trace_array *tr,
 			unsigned long ip, const char *fmt, va_list args)
 {
-	if (tracing_selftest_running && tr == &global_trace)
+	if (tracing_selftest_running && (tr->flags & TRACE_ARRAY_FL_GLOBAL))
 		return 0;
 
 	return __trace_array_vprintk(tr->array_buffer.buffer, ip, fmt, args);
@@ -3424,7 +3425,7 @@ int trace_array_printk(struct trace_array *tr,
 		return -ENOENT;
 
 	/* This is only allowed for created instances */
-	if (tr == &global_trace)
+	if (tr->flags & TRACE_ARRAY_FL_GLOBAL)
 		return 0;
 
 	if (!(tr->trace_flags & TRACE_ITER(PRINTK)))
@@ -3451,7 +3452,7 @@ int trace_array_init_printk(struct trace_array *tr)
 		return -ENOENT;
 
 	/* This is only allowed for created instances */
-	if (tr == &global_trace)
+	if (tr->flags & TRACE_ARRAY_FL_GLOBAL)
 		return -EINVAL;
 
 	return alloc_percpu_trace_buffer();
-- 
2.51.0


