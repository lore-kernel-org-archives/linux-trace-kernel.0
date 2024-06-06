Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF572199E84;
	Thu,  6 Jun 2024 21:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717708893; cv=none; b=LaLnPnOQVYoMzpyX3jzNqXDYUPfJHgNte0KoCrRokyD2roOfOr3ptS77Y7wSL00GPLM0yN4ZFYmHzTpgjyhCYU71mrGbALt31+Y2QvqDDKa+7UmkT9g8NkLtb8Ls3nkbuFaJzvFk6YUl5KUzKOrAbRVXVWMzGEga8Ww+faYfi2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717708893; c=relaxed/simple;
	bh=5vY8upmAWCSCeuI23auVBMfapEFPUJFegpBwQdZuq6o=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=D5lqPFXLwnJ4kZ4cGdX73Hub8eyh1o/KInmwi7gX/ZGOJDb72XUQj5xauvHrdf8lZE21ZsAuiy66ff7OeonlFeoDxfHkJ0vvhUbQhCfMksAl3xH2K/Jstcj4zD8DBJsOjJcB/K0CA4W5J6ehadeSuZZ8XjitpVujU9Ge35ZG1CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5983C4AF4D;
	Thu,  6 Jun 2024 21:21:32 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sFKYE-00000000qNi-19yO;
	Thu, 06 Jun 2024 17:21:38 -0400
Message-ID: <20240606212138.138119709@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 06 Jun 2024 17:17:48 -0400
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
Subject: [PATCH v3 13/13] tracing: Add last boot delta offset for stack traces
References: <20240606211735.684785459@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The addresses of a stack trace event are relative to the kallsyms. As that
can change between boots, when printing the stack trace from a buffer that
was from the last boot, it needs all the addresses to be added to the
"text_delta" that gives the delta between the addresses of the functions
for the current boot compared to the address of the last boot. Then it can
be passed to kallsyms to find the function name, otherwise it just shows a
useless list of addresses.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_output.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index b9d2c64c0648..48de93598897 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -1233,6 +1233,7 @@ static enum print_line_t trace_stack_print(struct trace_iterator *iter,
 	struct trace_seq *s = &iter->seq;
 	unsigned long *p;
 	unsigned long *end;
+	long delta = iter->tr->text_delta;
 
 	trace_assign_type(field, iter->ent);
 	end = (unsigned long *)((long)iter->ent + iter->ent_size);
@@ -1245,7 +1246,7 @@ static enum print_line_t trace_stack_print(struct trace_iterator *iter,
 			break;
 
 		trace_seq_puts(s, " => ");
-		seq_print_ip_sym(s, *p, flags);
+		seq_print_ip_sym(s, (*p) + delta, flags);
 		trace_seq_putc(s, '\n');
 	}
 
-- 
2.43.0


