Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A17812E1DE;
	Wed, 12 Jun 2024 23:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718234408; cv=none; b=cK2cuBGBAxRTq6fD5A+rj7V9EuGSHVlOA+LTxry3/73YrRTrneM53D4l6bToReYJNPmJnbKvTih4QoWOu1aeU4RARp9Getcxkg1hMxMvDYZSm2g0QIgN2mt1lMNsgt6c+b0Z7/lyynHf9fpvMfAle0Mn7EZ7pwTOfIgBdn2FDFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718234408; c=relaxed/simple;
	bh=5vY8upmAWCSCeuI23auVBMfapEFPUJFegpBwQdZuq6o=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ZBRPnknHOKKOb6xdjNOzkXJiKBPm7QKpudmU/ODDePz4c6b7XDc1mIzshmKAahTnhixIfhrlS55PKGVT+LHkkNAyYgy/DKuI91a5CltLHXRTQUxCUMfdPZ4ju7Xj7wCuSikV+xduEv1gkoW0BP73cMQfRNg0NVsv78/+sTzTiTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E28EC4AF1D;
	Wed, 12 Jun 2024 23:20:08 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sHXGV-00000001dgR-1Bkb;
	Wed, 12 Jun 2024 19:20:27 -0400
Message-ID: <20240612232027.145807384@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 12 Jun 2024 19:19:47 -0400
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
Subject: [PATCH v6 13/13] tracing: Add last boot delta offset for stack traces
References: <20240612231934.608252486@goodmis.org>
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


