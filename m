Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D773382DA;
	Fri,  6 Feb 2026 19:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770407936; cv=none; b=nopS7Vw9Gz7id0W2VA0XaqDfeDSb+YW4RlUDnWFrPoCAHULS4GxaYMBr/vQsPEzOV5Ei0ofRN+W4NwmX6erKeOapYm2zt4oqtXuBeD9wlaNqdyXHt/o7Hv/M63zcyqDasJwW3QuWZBe5E0FFPYu9rRIYfK1iT+UP0ddMCZGTyeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770407936; c=relaxed/simple;
	bh=s29KvyR1cTcgp9eIV9JmO39WhdYvRZ0cDxzveXQC3lw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Hj+vt5Zi/ygcoX6rOyxOawKHtPbJMQqqJAHEfUJvE+a5n5rEYLs8ZG9VrhCsetkFcdekNkCJQqtql54t0qRfL4manWyqWSTb1gDXuXYeZn+57bk+LJIeQL9s08HkDuULMkoqBUCX2LHmw67N3l4fQXeDb1RhtSmkLlREGrT43RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EdY+g/6P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EdY+g/6P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92F63C116C6;
	Fri,  6 Feb 2026 19:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770407936;
	bh=s29KvyR1cTcgp9eIV9JmO39WhdYvRZ0cDxzveXQC3lw=;
	h=Date:From:To:Cc:Subject:References:From;
	b=EdY+g/6PzFU6A6qmAUCcnFS+VXEGVjxoAtZW8fMP9g+lVe97I/LIpzndhPDhStjiY
	 x7o7y/1ic74t2bT5NWbbp/4W7ePF6Q8KtBHmWKogt03v5Fcdm1SoNffJo/sbDYvWRm
	 dH/NoeNsZlDdTZu2vz65/y4kbM+Ym+KTR/h5/5HPmOjIsOydbNupeTRAMu49y1cXbo
	 JJyV4enGt/9GWH27S51e/O89zWgJbu+HnmW24U02uVgU33NMZMVS7wQGOLseED1VaA
	 JifoQuvnvf9KOJosFq2OAfG443f+kwy4+IDoV1aEDs4k3qH+Jme0Qros49p5Yme8cW
	 sxOpfv03xI89Q==
Received: from rostedt by gandalf with local (Exim 4.99.1)
	(envelope-from <rostedt@kernel.org>)
	id 1voRzL-0000000A6oE-3EiB;
	Fri, 06 Feb 2026 14:59:35 -0500
Message-ID: <20260206195935.625485805@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 06 Feb 2026 14:37:46 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 05/12] tracing: Make printk_trace global for tracing system
References: <20260206193741.767171392@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The printk_trace is used to determine which trace_array trace_printk()
writes to. By making it a global variable among the tracing subsystem it
will allow the trace_printk functions to be moved out of trace.c and still
have direct access to that variable.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 2 +-
 kernel/trace/trace.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 061c154c0618..1170fcf686a6 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -534,7 +534,7 @@ static struct trace_array global_trace = {
 	.trace_flags = TRACE_DEFAULT_FLAGS,
 };
 
-static struct trace_array *printk_trace = &global_trace;
+struct trace_array *printk_trace = &global_trace;
 
 /* List of trace_arrays interested in the top level trace_marker */
 static LIST_HEAD(marker_copies);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 63260595ac8f..73a2ab195114 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -487,6 +487,8 @@ extern bool trace_clock_in_ns(struct trace_array *tr);
 
 extern unsigned long trace_adjust_address(struct trace_array *tr, unsigned long addr);
 
+extern struct trace_array *printk_trace;
+
 /*
  * The global tracer (top) should be the first trace array added,
  * but we check the flag anyway.
-- 
2.51.0


