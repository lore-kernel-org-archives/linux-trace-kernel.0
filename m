Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAD427BF8D;
	Tue,  6 May 2025 15:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746544602; cv=none; b=rpEEPooAWVsFSKMvbCfuJ0yGj9oJdFOqp2LxOZza6fAgqi4KZTM6BSO55fU1w6NovEppFmHwAgj5jxoYr0js/QIwxdxyms6HkLtJHR19YzIUX+CXyxbn7C0iyz2twf7ADlF7lsePLCyDTtRzhIPlqqtvHt1nh7IP2b/Pa5Zutl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746544602; c=relaxed/simple;
	bh=+rKFcJCqS8GQHxMRegbXmSXTuTfl6b3IIxVnX4FcEQA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=TPHeJC1xiTaf8Qtn+3JuaiDnt3zWgV4rNFIjOy1HtmHfxHIG5KujmshQCykuY3AiqBo/P3mstWYGiJY2sQ9zrdwMOGp+aqpUjsf+t/QlAVTrKsVDPPE7DJDNmPzhe1mneZ/sU4hePHu7W38+6NgGOiqMUeos/AKf5rV3IeNyGTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E30E5C4CEE4;
	Tue,  6 May 2025 15:16:40 +0000 (UTC)
Date: Tue, 6 May 2025 11:16:48 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3] tracing: Update function trace addresses with module
 addresses
Message-ID: <20250506111648.5df7f3ec@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

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
Changes from v2: https://lore.kernel.org/20250325213919.460188156@goodmis.org

- Rebased on v6.15-rc5

- Removed unneeded "delta" parameter from print_fn_trace()

 kernel/trace/trace_output.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index b9ab06c99543..aab6816f0249 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -1086,11 +1086,11 @@ enum print_line_t trace_nop_print(struct trace_iterator *iter, int flags,
 }
 
 static void print_fn_trace(struct trace_seq *s, unsigned long ip,
-			   unsigned long parent_ip, long delta,
-			   unsigned long *args, int flags)
+			   unsigned long parent_ip, unsigned long *args,
+			   struct trace_array *tr, int flags)
 {
-	ip += delta;
-	parent_ip += delta;
+	ip = trace_adjust_address(tr, ip);
+	parent_ip = trace_adjust_address(tr, parent_ip);
 
 	seq_print_ip_sym(s, ip, flags);
 	if (args)
@@ -1119,8 +1119,7 @@ static enum print_line_t trace_fn_trace(struct trace_iterator *iter, int flags,
 	else
 		args = NULL;
 
-	print_fn_trace(s, field->ip, field->parent_ip, iter->tr->text_delta,
-		       args, flags);
+	print_fn_trace(s, field->ip, field->parent_ip, args, iter->tr, flags);
 	trace_seq_putc(s, '\n');
 
 	return trace_handle_return(s);
@@ -1706,7 +1705,7 @@ static enum print_line_t trace_print_print(struct trace_iterator *iter,
 
 	trace_assign_type(field, iter->ent);
 
-	ip = field->ip + iter->tr->text_delta;
+	ip = trace_adjust_address(iter->tr, field->ip);
 
 	seq_print_ip_sym(s, ip, flags);
 	trace_seq_printf(s, ": %s", field->buf);
@@ -1792,7 +1791,7 @@ trace_func_repeats_print(struct trace_iterator *iter, int flags,
 
 	trace_assign_type(field, iter->ent);
 
-	print_fn_trace(s, field->ip, field->parent_ip, iter->tr->text_delta, NULL, flags);
+	print_fn_trace(s, field->ip, field->parent_ip, NULL, iter->tr, flags);
 	trace_seq_printf(s, " (repeats: %u, last_ts:", field->count);
 	trace_print_time(s, iter,
 			 iter->ts - FUNC_REPEATS_GET_DELTA_TS(field));
-- 
2.47.2

