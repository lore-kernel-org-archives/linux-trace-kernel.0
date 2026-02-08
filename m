Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F096D2C11D1;
	Sun,  8 Feb 2026 03:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770521047; cv=none; b=uYXq89k5cYFu5uRLDaO5ax+ExhiJAtK1Yn9ZbtnyROFOUYRGn8IvoD7BDoMnYSgJvG9wHNnFQvw6jpFeOx2JYrP8bNzm2gHU8DB4V10syHYcDt3GSWmhKBpM08bsXCuth3YidH7Vsito1i6B/J476/GcmTmua3bNb6ZYYUfgdxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770521047; c=relaxed/simple;
	bh=ofZYtIuKZZzoDoktKHjlNYL9T3iTkdESp5qanyFNzIM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=d6Nd0fOIF9pi3CnK9IE1af2cN0dpLtzgQWzsXepfbaIOP6AlglyP5lbG8uMItK1ZFF9CO6bWL8NNnik+mEEP6kTCGygv1IDhAEagGHHC71voVdbhi6c3F32f7omfbg4pR6wBlan/I+6AdnXkwxvGY6zIe1qZZdvOPfjN+I2gPvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aE57g/Uv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aE57g/Uv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF069C4CEF7;
	Sun,  8 Feb 2026 03:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770521046;
	bh=ofZYtIuKZZzoDoktKHjlNYL9T3iTkdESp5qanyFNzIM=;
	h=Date:From:To:Cc:Subject:References:From;
	b=aE57g/UvywN9NEb3lOuiaZAKvI5p/ut5r7rzvcNLabTLlKagL4t2QoNIynVKNCn+T
	 uXBIgUFnU9HHb1Y6dvnus393za5kupzoTLN5KUlNxcCP/nz4v3/h358NpgCzUk/OyQ
	 BMtOi5UHCDueCji9eDu//DBAjpCNDKLHFFGUWED4HWdUX6dmp3/EbZyFqlCSaSGBdq
	 LZoF8RiPgydV27TbnOtuJODOCGQqzU5VYyq1PIjeCaZp9Ph5N2pmrm6IgtW4HD5DmI
	 p9pDpHZTFDvTA3IKL1/q1Xf+vkpyquDGTE6dlArKkY9YQzZcRsxBH4jHTZOQyxz9Sw
	 MvGoR+gOFaUrQ==
Received: from rostedt by gandalf with local (Exim 4.99.1)
	(envelope-from <rostedt@kernel.org>)
	id 1vovPm-0000000AOdC-1Feg;
	Sat, 07 Feb 2026 22:24:50 -0500
Message-ID: <20260208032450.144525891@kernel.org>
User-Agent: quilt/0.68
Date: Sat, 07 Feb 2026 22:24:22 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 05/10] tracing: Make printk_trace global for tracing system
References: <20260208032417.262341179@kernel.org>
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
index a515b5241391..4a73822e2603 100644
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
index 605ee23f3262..921e4daa2825 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -482,6 +482,8 @@ extern bool trace_clock_in_ns(struct trace_array *tr);
 
 extern unsigned long trace_adjust_address(struct trace_array *tr, unsigned long addr);
 
+extern struct trace_array *printk_trace;
+
 /*
  * The global tracer (top) should be the first trace array added,
  * but we check the flag anyway.
-- 
2.51.0


