Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EC333ADB4;
	Fri,  6 Feb 2026 19:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770407937; cv=none; b=FwAzrXfRKog/S14gHfDYxrffKoNJn8RGXO2O08Yvn7LCkw0JiK1IEFqXrm35hpdpUt+PXQzjgF3cnbiNGnhwdR8B7OLSbJCNX5YS7fTmSqpXKaLb6M4BqhZrLquJ/CPbjSE5ekpQyLrSYdyHOx0/+2rL7zHp/fb8e5FXm3V0sks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770407937; c=relaxed/simple;
	bh=ZUcEKZAtlFAIbpjaZX6mY8OMNPSAtHWZIBIZL+GAaZc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ClsIy6wr85yysydqz/GzgpsjWT+XGNwqBsYGrxPA2WLsjiU3a+M5+TqZK+NWTMgTWzFv9SARjQl1CMEU5womNCNMDbWIzrZCPzAsCTsq+2VN8vrXMpolQlJAmr/+pI97mwYKPs2XMF1JoZqArK09Mhfkfp4NAytFZVebR7RiV74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MYQHsmu7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MYQHsmu7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98377C19422;
	Fri,  6 Feb 2026 19:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770407937;
	bh=ZUcEKZAtlFAIbpjaZX6mY8OMNPSAtHWZIBIZL+GAaZc=;
	h=Date:From:To:Cc:Subject:References:From;
	b=MYQHsmu7EaLuBPy6H8cnXjX8FepyGTq+eKCdkafHDW1DH9CBZ5k/PNabcFsbENRuw
	 osDxYfsyHH32NjrLGKDVHx8UjtylPtLCIIha5VJWfkJnXxtJPbOfhId3XqEx8NwxDc
	 OgeF0gsxAsISTRFx3jZm8aanKn9OoMFi64IAR5rbseQ1y/uTzXhnMv9u+e84NFokXH
	 4sfoO9VstRYzQ8RyIFxFgK+DuCb6WnxrsxSM8pWUuGWW6whJ100Qo+gnYAE0ojwXfb
	 0sgcaG3Kz+JfFczj2hPL8cfOmsn86N1eFz2kyk84MSxUkKx5giA7S/FYx06YBq07fA
	 PjgMSW1MLJ2/w==
Received: from rostedt by gandalf with local (Exim 4.99.1)
	(envelope-from <rostedt@kernel.org>)
	id 1voRzM-0000000A6rE-3Bum;
	Fri, 06 Feb 2026 14:59:36 -0500
Message-ID: <20260206195936.617080218@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 06 Feb 2026 14:37:52 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 11/12] tracing: Move tracing_set_filter_buffering() into trace_events_hist.c
References: <20260206193741.767171392@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The function tracing_set_filter_buffering() is only used in
trace_events_hist.c. Move it to that file and make it static.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c             | 20 --------------------
 kernel/trace/trace.h             |  1 -
 kernel/trace/trace_events_hist.c | 20 ++++++++++++++++++++
 3 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 6a0cea7e63b0..5bc22d966834 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7134,26 +7134,6 @@ u64 tracing_event_time_stamp(struct trace_buffer *buffer, struct ring_buffer_eve
 	return ring_buffer_event_time_stamp(buffer, rbe);
 }
 
-/*
- * Set or disable using the per CPU trace_buffer_event when possible.
- */
-int tracing_set_filter_buffering(struct trace_array *tr, bool set)
-{
-	guard(mutex)(&trace_types_lock);
-
-	if (set && tr->no_filter_buffering_ref++)
-		return 0;
-
-	if (!set) {
-		if (WARN_ON_ONCE(!tr->no_filter_buffering_ref))
-			return -EINVAL;
-
-		--tr->no_filter_buffering_ref;
-	}
-
-	return 0;
-}
-
 struct ftrace_buffer_info {
 	struct trace_iterator	iter;
 	void			*spare;
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index f85c94f2e2d9..374b7c392f0a 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -480,7 +480,6 @@ extern struct trace_array *trace_array_find(const char *instance);
 extern struct trace_array *trace_array_find_get(const char *instance);
 
 extern u64 tracing_event_time_stamp(struct trace_buffer *buffer, struct ring_buffer_event *rbe);
-extern int tracing_set_filter_buffering(struct trace_array *tr, bool set);
 extern int tracing_set_clock(struct trace_array *tr, const char *clockstr);
 
 extern bool trace_clock_in_ns(struct trace_array *tr);
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 0fc641461be5..e6f449f53afc 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -6531,6 +6531,26 @@ static bool existing_hist_update_only(char *glob,
 	return updated;
 }
 
+/*
+ * Set or disable using the per CPU trace_buffer_event when possible.
+ */
+static int tracing_set_filter_buffering(struct trace_array *tr, bool set)
+{
+	guard(mutex)(&trace_types_lock);
+
+	if (set && tr->no_filter_buffering_ref++)
+		return 0;
+
+	if (!set) {
+		if (WARN_ON_ONCE(!tr->no_filter_buffering_ref))
+			return -EINVAL;
+
+		--tr->no_filter_buffering_ref;
+	}
+
+	return 0;
+}
+
 static int hist_register_trigger(char *glob,
 				 struct event_trigger_data *data,
 				 struct trace_event_file *file)
-- 
2.51.0


