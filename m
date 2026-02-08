Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D64B2C3259;
	Sun,  8 Feb 2026 03:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770521047; cv=none; b=UoC0PY9MxW2YA/iFvIwvG/Uyan2i+bDZROa4p76FkXlfJX/X6m0pdCfl50oydCzWlleTiitMX8Ri9ghDccxEucNmMpLt5NY1y4q2IONNjJwwDtlFnPVdUhO5l+Tcn+K8nrmWBZnuvoLQmp1IOflce7SSbo6cpXFgx5C57ZYaQt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770521047; c=relaxed/simple;
	bh=3Xwg0vZ1urflHR8mszNbLj+Cni7vlXl8An6HdvjgI7c=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=cuB/IY0GNX1ktxwxet5/YXsE9ZL7Kr6CjryHHkkCZbTMdg4q6nJXCnPtWLoYoMoSgPNWIy7dQOPVuSp3WivQHFxpEe8IuX1sneE7qNrIfJsCDrHBp9QYVD835anJf2aoZw30YYoCom0x/7NE43h4ZDJWFwiFk0/SUU0JszA/pIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lzGwptbS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lzGwptbS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF95C2BCB5;
	Sun,  8 Feb 2026 03:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770521047;
	bh=3Xwg0vZ1urflHR8mszNbLj+Cni7vlXl8An6HdvjgI7c=;
	h=Date:From:To:Cc:Subject:References:From;
	b=lzGwptbS7WXnnGwBMxSsDz3Ih++eoFbR+Dia6q2KmRUeapqO8FvzNEq5fF0n/rpSp
	 7baq3bYnVb1EBBuXuoN8CHLwtMas7ikHPDDSl8RDf2aKpBOrDmOV10OCQl99C7g1Nq
	 Y7tbW8Qo4vXUaeEebF1pjT21+bKDdcoyfC4v+hHTTBN9pab3JQUJ/xIXDWXjwvwkZU
	 lRX9BLoyjic6gXRjGUrB9flz3Rit5pTPV2t3XvB0ed89BxXk0blRZIG682wDeTVVCr
	 9SOAgs4+rY6GGheSkA/AABqBD4e0qekTIrdKSkBN+1UZ36NVy6knFGnAesvQrNj0TF
	 WiTefVmnmjTfA==
Received: from rostedt by gandalf with local (Exim 4.99.1)
	(envelope-from <rostedt@kernel.org>)
	id 1vovPm-0000000AOdg-1yJe;
	Sat, 07 Feb 2026 22:24:50 -0500
Message-ID: <20260208032450.318864210@kernel.org>
User-Agent: quilt/0.68
Date: Sat, 07 Feb 2026 22:24:23 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 06/10] tracing: Make tracing_update_buffers() take NULL for global_trace
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

Have tracing_update_buffers() take NULL for its trace_array to denote it
should work on the global_trace top level trace_array allows that function
to be used outside of trace.c and still update the global_trace
trace_array.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 4a73822e2603..601b6f622391 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3234,7 +3234,7 @@ void trace_printk_init_buffers(void)
 	pr_warn("**********************************************************\n");
 
 	/* Expand the buffers to set size */
-	if (tracing_update_buffers(&global_trace) < 0)
+	if (tracing_update_buffers(NULL) < 0)
 		pr_err("Failed to expand tracing buffers for trace_printk() calls\n");
 	else
 		buffers_allocated = 1;
@@ -6186,6 +6186,9 @@ int tracing_update_buffers(struct trace_array *tr)
 {
 	int ret = 0;
 
+	if (!tr)
+		tr = &global_trace;
+
 	guard(mutex)(&trace_types_lock);
 
 	update_last_data(tr);
-- 
2.51.0


