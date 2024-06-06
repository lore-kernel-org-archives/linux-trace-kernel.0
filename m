Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A051993A2;
	Thu,  6 Jun 2024 21:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717708892; cv=none; b=aBcNK1MU5u0smiFbw2Ksg+ZOeIaDPpE48qegnArz/r7sQeoCo8eunZ39CFJj8l+ussslBaV8Cs1Q1WqI58P63q2oMPTL3z4Q7j3doNkS8mWGFAwMZD/DIXRaxjBw/Ylb8T5YE2z/yHmqmEQYi7RTbUGH0HkSmUV+ENcMfCmrHPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717708892; c=relaxed/simple;
	bh=IE1IK2OKn7/pafSQ0ncO+HLzuopsT1q+/33iYZS7wTg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=pe200Fh2uCZQFjIMK7q735jwWxX5fqNF3eB8jveacBJC28ny3KfGghBCKZYXEls1e1j3hoWUWVBtONYTMZDh8RXcIbSukBxx8kCppZvj4uxfvyK72d3kEp31dl4vT/bQEQm78p8XSMTvu7UZ3u1bF4sO55SsslZasJqsRp73BWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1267C3277B;
	Thu,  6 Jun 2024 21:21:32 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sFKYE-00000000qNC-0Urt;
	Thu, 06 Jun 2024 17:21:38 -0400
Message-ID: <20240606212137.979724516@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 06 Jun 2024 17:17:47 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vincent Donnefort <vdonnefort@google.com>,
 Joel Fernandes <joel@joelfernandes.org>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 suleiman@google.com,
 Thomas Gleixner <tglx@linutronix.de>,
 Vineeth Pillai <vineeth@bitbyteword.org>,
 Youssef Esmat <youssefesmat@google.com>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 Alexander Graf <graf@amazon.com>,
 Baoquan He <bhe@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 David Howells <dhowells@redhat.com>,
 Mike Rapoport <rppt@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Tony Luck <tony.luck@intel.com>,
 Guenter Roeck <linux@roeck-us.net>,
 Ross Zwisler <zwisler@google.com>,
 Kees Cook <keescook@chromium.org>
Subject: [PATCH v3 12/13] tracing: Update function tracing output for previous boot buffer
References: <20240606211735.684785459@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

For a persistent ring buffer that is saved across boots, if function
tracing was performed in the previous boot, it only saves the address of
the functions and uses "%pS" to print their names. But the current boot,
those functions may be in different locations. The persistent meta-data
saves the text delta between the two boots and can be used to find the
address of the saved function of where it is located in the current boot.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_output.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index d8b302d01083..b9d2c64c0648 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -990,8 +990,11 @@ enum print_line_t trace_nop_print(struct trace_iterator *iter, int flags,
 }
 
 static void print_fn_trace(struct trace_seq *s, unsigned long ip,
-			   unsigned long parent_ip, int flags)
+			   unsigned long parent_ip, long delta, int flags)
 {
+	ip += delta;
+	parent_ip += delta;
+
 	seq_print_ip_sym(s, ip, flags);
 
 	if ((flags & TRACE_ITER_PRINT_PARENT) && parent_ip) {
@@ -1009,7 +1012,7 @@ static enum print_line_t trace_fn_trace(struct trace_iterator *iter, int flags,
 
 	trace_assign_type(field, iter->ent);
 
-	print_fn_trace(s, field->ip, field->parent_ip, flags);
+	print_fn_trace(s, field->ip, field->parent_ip, iter->tr->text_delta, flags);
 	trace_seq_putc(s, '\n');
 
 	return trace_handle_return(s);
@@ -1674,7 +1677,7 @@ trace_func_repeats_print(struct trace_iterator *iter, int flags,
 
 	trace_assign_type(field, iter->ent);
 
-	print_fn_trace(s, field->ip, field->parent_ip, flags);
+	print_fn_trace(s, field->ip, field->parent_ip, iter->tr->text_delta, flags);
 	trace_seq_printf(s, " (repeats: %u, last_ts:", field->count);
 	trace_print_time(s, iter,
 			 iter->ts - FUNC_REPEATS_GET_DELTA_TS(field));
-- 
2.43.0


