Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2ACA338F26;
	Fri,  6 Feb 2026 19:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770407937; cv=none; b=oBFWvkxISp+IaiIT7w9lsIKbGRO5zrryzGRCPRvShSkHLVBBZDtzI3F/LhFV2FcLRXM/gKBfjdjVdQGHHHQpfscpQNygN3Br8dODIN9uKOEZGbPdn6zBIrbmy8C38466KHSOEuDhXfCLgOt1ficqJWAm9TwuF1CaWG1OQKkB+n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770407937; c=relaxed/simple;
	bh=v7tx0fb8mN8IPP3PDF9fvTs6sEupxknIdsg9SHi8S4s=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=pT7hNl35m7SLQnb+Np9ty5HdWRWvlS6LS8u0DpTLw6GmioKcY8QVwHN7XvIpeBZuGR9AFvvelAED67Rj6+UMnGDOv3rsNNJn4Fn3fMrmt6lWckl9LhGykhM5gRU2rZkweIaP51asIy8xJnK9XnskUlQCspd28YZaTm7GR7+Sj6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mr+RBO/G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mr+RBO/G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B96B9C19424;
	Fri,  6 Feb 2026 19:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770407936;
	bh=v7tx0fb8mN8IPP3PDF9fvTs6sEupxknIdsg9SHi8S4s=;
	h=Date:From:To:Cc:Subject:References:From;
	b=Mr+RBO/GiZkNnYqVwI+jC5uXYnMQKyhzb14ajjazViUfOICHIUeYn64qwIj5fLc/Q
	 HhaMRicu/uiEFm6moZbZPW7GJ5DEbdRKw6nKJUIsvlR0oqbuRT1YfQk94rgZXvzhwF
	 Ym3yE5Tfg1rD2T/JW7QgSbUvdhuXZYFyPpoK84F+ChIGu+Dq23TEtcpGuSgqTpdbIL
	 sLFR3ICBhLN63u3XhRMa1SGWzgjMEjEjdp9sh8xGDPJyXWZ9DfUmyLg89shmmh9peL
	 CdPnalnAor3oSCsXXhZqRjnpOiXHZ5Mg/t5if2hnpsYv/sDqRFA1vI9cHeOpfs9ZtF
	 cyXVRJe+j9ScQ==
Received: from rostedt by gandalf with local (Exim 4.99.1)
	(envelope-from <rostedt@kernel.org>)
	id 1voRzL-0000000A6oi-3ufd;
	Fri, 06 Feb 2026 14:59:35 -0500
Message-ID: <20260206195935.791669128@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 06 Feb 2026 14:37:47 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 06/12] tracing: Make tracing_update_buffers() take NULL for global_trace
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

Have tracing_update_buffers() take NULL for its trace_array to denote it
should work on the global_trace top level trace_array allows that function
to be used outside of trace.c and still update the global_trace
trace_array.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 1170fcf686a6..a68948ac8bf9 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3236,7 +3236,7 @@ void trace_printk_init_buffers(void)
 	pr_warn("**********************************************************\n");
 
 	/* Expand the buffers to set size */
-	if (tracing_update_buffers(&global_trace) < 0)
+	if (tracing_update_buffers(NULL) < 0)
 		pr_err("Failed to expand tracing buffers for trace_printk() calls\n");
 	else
 		buffers_allocated = 1;
@@ -6188,6 +6188,9 @@ int tracing_update_buffers(struct trace_array *tr)
 {
 	int ret = 0;
 
+	if (!tr)
+		tr = &global_trace;
+
 	guard(mutex)(&trace_types_lock);
 
 	update_last_data(tr);
-- 
2.51.0


