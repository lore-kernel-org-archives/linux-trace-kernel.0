Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA7C1EB187;
	Tue, 25 Mar 2025 21:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742938715; cv=none; b=iwoxHxaAo0FWX8O1E9KmqfkSD17X9W+A5lFpz6lz1L8/NrFlhSO0VINUXiBeUBXzDKIgws8YnrF/Y6idleVQCWRTMfR8/nEFcwCK/HoL5TQ8qMWbBLIeWvVdTHZq7W3QQ/Np4IzfbN9Qp3RCF93nvLaJlZy4f1J/fh41Hiybj6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742938715; c=relaxed/simple;
	bh=oiUvwgsMxigofpaZR2VYq41+5gaMqUJBgwke1cfi7xw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ocAL0/CopG+f16O8rN9tZP8IHiisAqqD+YIRd/MDmULlfOJVjm239qSDQVN3G/EPywuitQEAduBjzPCo+vY5Gb9/g6wkb2uat2pvI6SGNdvFiUgQ6HNWEYYpXQQnkQ85WZE/uJtS2+cbUXSWri1hrjDCOMq8KkhmXfE+BG0fgLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91E75C4CEE4;
	Tue, 25 Mar 2025 21:38:34 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1txBzT-00000002Veb-2Wbh;
	Tue, 25 Mar 2025 17:39:19 -0400
Message-ID: <20250325213919.460188156@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 25 Mar 2025 17:38:46 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 1/4] tracing: Update function trace addresses with module addresses
References: <20250325213845.844200633@goodmis.org>
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
index 1ad54fcf25cb..ca8e09436a0a 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -1006,10 +1006,10 @@ enum print_line_t trace_nop_print(struct trace_iterator *iter, int flags,
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
 
@@ -1028,7 +1028,7 @@ static enum print_line_t trace_fn_trace(struct trace_iterator *iter, int flags,
 
 	trace_assign_type(field, iter->ent);
 
-	print_fn_trace(s, field->ip, field->parent_ip, iter->tr->text_delta, flags);
+	print_fn_trace(s, field->ip, field->parent_ip, iter->tr, flags);
 	trace_seq_putc(s, '\n');
 
 	return trace_handle_return(s);
@@ -1614,7 +1614,7 @@ static enum print_line_t trace_print_print(struct trace_iterator *iter,
 
 	trace_assign_type(field, iter->ent);
 
-	ip = field->ip + iter->tr->text_delta;
+	ip = trace_adjust_address(iter->tr, field->ip);
 
 	seq_print_ip_sym(s, ip, flags);
 	trace_seq_printf(s, ": %s", field->buf);
@@ -1700,7 +1700,7 @@ trace_func_repeats_print(struct trace_iterator *iter, int flags,
 
 	trace_assign_type(field, iter->ent);
 
-	print_fn_trace(s, field->ip, field->parent_ip, iter->tr->text_delta, flags);
+	print_fn_trace(s, field->ip, field->parent_ip, iter->tr, flags);
 	trace_seq_printf(s, " (repeats: %u, last_ts:", field->count);
 	trace_print_time(s, iter,
 			 iter->ts - FUNC_REPEATS_GET_DELTA_TS(field));
-- 
2.47.2


