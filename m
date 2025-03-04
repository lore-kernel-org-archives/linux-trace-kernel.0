Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA201FAC4C;
	Tue,  4 Mar 2025 23:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741130122; cv=none; b=U8ShUg608MvZuT9+8AzXq/CMS3e2sG8BBfXkW1LrEYmuWRRk1dF0AVSFO4xo9ql5ZmTrAlCJFnVW1pZHnDnzzyKK5o2epo9262OKrYKS/4/J3uqgt8djMxZ6xK7ZlaWGWQNHTChEoMT9Ta6JL7f08dR9p8CskKh6DVlsnfp+xkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741130122; c=relaxed/simple;
	bh=Sc+tHgnrwcvbiAJXC4eaEryDgMZlPRgI9XOGIB2esok=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=sc7o5eh/054ot9MGWQu2vs52WhoM/JyAHWBXKG73YP9Tkl8CK5tUblejI59blbPjDuAzLni+mEs9lkJ9HIYc2KJM0KmQMEtnbNb6H4LRigTUHNgH/a25qz4De3qSmTtvK4oVLQYMuDLN1tW+htT/oLOXADwo7t18xEX81BTltm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EE26C4CEE5;
	Tue,  4 Mar 2025 23:15:22 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tpbUo-0000000CSZP-12u6;
	Tue, 04 Mar 2025 18:16:18 -0500
Message-ID: <20250304231618.104482909@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 04 Mar 2025 18:15:46 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 1/4] tracing: Update function trace addresses with module addresses
References: <20250304231545.708806702@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Now that module addresses are saved in the persistent ring buffer, their
addresses can be used to adjust the address in the persistent ring buffer
to the address of the module that is currently loaded.

Instead of blindly using the text_delta that only works for core kernel
code, call the trace_adjust_address() that will see if the address matches
an address saved in the persistent ring buffer, and then uses that against
the matching module if it is loaded.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_output.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index a5336c4ece8e..5f3b698afc07 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -1005,10 +1005,10 @@ enum print_line_t trace_nop_print(struct trace_iterator *iter, int flags,
 }
 
 static void print_fn_trace(struct trace_seq *s, unsigned long ip,
-			   unsigned long parent_ip, long delta, int flags)
+			   unsigned long parent_ip, struct trace_array *tr, int flags)
 {
-	ip += delta;
-	parent_ip += delta;
+	ip = trace_adjust_address(tr, ip);
+	parent_ip = trace_adjust_address(tr, parent_ip);
 
 	seq_print_ip_sym(s, ip, flags);
 
@@ -1027,7 +1027,7 @@ static enum print_line_t trace_fn_trace(struct trace_iterator *iter, int flags,
 
 	trace_assign_type(field, iter->ent);
 
-	print_fn_trace(s, field->ip, field->parent_ip, iter->tr->text_delta, flags);
+	print_fn_trace(s, field->ip, field->parent_ip, iter->tr, flags);
 	trace_seq_putc(s, '\n');
 
 	return trace_handle_return(s);
@@ -1613,7 +1613,7 @@ static enum print_line_t trace_print_print(struct trace_iterator *iter,
 
 	trace_assign_type(field, iter->ent);
 
-	ip = field->ip + iter->tr->text_delta;
+	ip = trace_adjust_address(iter->tr, field->ip);
 
 	seq_print_ip_sym(s, ip, flags);
 	trace_seq_printf(s, ": %s", field->buf);
@@ -1699,7 +1699,7 @@ trace_func_repeats_print(struct trace_iterator *iter, int flags,
 
 	trace_assign_type(field, iter->ent);
 
-	print_fn_trace(s, field->ip, field->parent_ip, iter->tr->text_delta, flags);
+	print_fn_trace(s, field->ip, field->parent_ip, iter->tr, flags);
 	trace_seq_printf(s, " (repeats: %u, last_ts:", field->count);
 	trace_print_time(s, iter,
 			 iter->ts - FUNC_REPEATS_GET_DELTA_TS(field));
-- 
2.47.2


