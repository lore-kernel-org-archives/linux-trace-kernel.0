Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BC92F12CF;
	Fri, 14 Nov 2025 19:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763148181; cv=none; b=iemKEJhQrgFgQ954e868Dt3mtPZh46yGYAJRXKmTXFFRH+KhxnPh9KT3Y41m2WcmaZSns4vaqEJo7g6Ki0iWpoQRomtMdLhkjV5i98HMoVNNnxz0p10fOYRQ3a+rg0nIO6wvhO/MH10ZuIYnEK2F/+vSU6sA2YmJ3XAYjngliXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763148181; c=relaxed/simple;
	bh=q+p/ydHkrE15q7zh6goHjjrRvmWFN9DIXiJYtL0jZkg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=AvYLvEPrrFuyQDC4Tah233fgi3ALcqJWKww50fcaT81wjYp8kqG24EiVDoMOJTAwf5QyaqiyQvKbzR9bPsmiUTZEXDEJzhAzUOdQo6l8jhjnNGHdPiczuDba0i+VhIn9VloNs3v/opdQZU/gBQC+VBVE0ytYsPJEONZomA8WwZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzDY8r6u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzDY8r6u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD1E3C19422;
	Fri, 14 Nov 2025 19:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763148180;
	bh=q+p/ydHkrE15q7zh6goHjjrRvmWFN9DIXiJYtL0jZkg=;
	h=Date:From:To:Cc:Subject:References:From;
	b=kzDY8r6u6T8Ly13owgnfoEgukQnH3nPzmKHexMbqNVAJ46otozKebmMmdbxGaEaoZ
	 VmEiHscVZj9Bgrfr5Lo4ZEs407DiBzVIs1VdXmq2VrSX1P0S3kdAbjdrDiK16KRAzs
	 iNJZvOWlwt+pzPyV0jhC7LEwE4Kj+NmpFDbrGNYThsrAIG2wycRbqY6zO37/83Uc9L
	 OWXPDFmImHm/+MyNwXEnLbZjypgXBfeWmWLnj+M5DhB2zCqMnXxHgpmMf8Fp5MXWl1
	 miQPeNFJHqQ6KVfyHWYSk39buGcclnTidXOBg/uxkjVGX9sfPXubBSUMSbA+JfpNXz
	 V/hmPOOZycHBw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vJzOB-00000001p9W-16bS;
	Fri, 14 Nov 2025 14:23:19 -0500
Message-ID: <20251114192319.117123664@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 14 Nov 2025 14:22:33 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 4/4] tracing: Convert function graph set_flags() to use a switch()
 statement
References: <20251114192229.829042264@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Currently the set_flags() of the function graph tracer has a bunch of:

  if (bit == FLAG1) {
	[..]
  }

  if (bit == FLAG2) {
	[..]
  }

To clean it up a bit, convert it over to a switch statement.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_functions_graph.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 12315eb65925..44d5dc5031e2 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -1664,7 +1664,8 @@ func_graph_set_flag(struct trace_array *tr, u32 old_flags, u32 bit, int set)
 	if (!!set == !!(tr->current_trace_flags->val & bit))
 		return 0;
 
-	if (bit == TRACE_GRAPH_SLEEP_TIME) {
+	switch (bit) {
+	case TRACE_GRAPH_SLEEP_TIME:
 		if (set) {
 			fgraph_no_sleep_time--;
 			if (WARN_ON_ONCE(fgraph_no_sleep_time < 0))
@@ -1672,19 +1673,20 @@ func_graph_set_flag(struct trace_array *tr, u32 old_flags, u32 bit, int set)
 		} else {
 			fgraph_no_sleep_time++;
 		}
-	}
+		break;
 
-	if (bit == TRACE_GRAPH_PRINT_IRQS) {
+	case TRACE_GRAPH_PRINT_IRQS:
 		if (set)
 			ftrace_graph_skip_irqs--;
 		else
 			ftrace_graph_skip_irqs++;
 		if (WARN_ON_ONCE(ftrace_graph_skip_irqs < 0))
 			ftrace_graph_skip_irqs = 0;
-	}
+		break;
 
-	if (bit == TRACE_GRAPH_ARGS)
+	case TRACE_GRAPH_ARGS:
 		return ftrace_graph_trace_args(tr, set);
+	}
 
 	return 0;
 }
-- 
2.51.0


