Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42454324B35;
	Tue, 23 Sep 2025 13:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758632755; cv=none; b=LUMB4RYkrA1D/uxffyus2rW2DfkU+UD0hJDwC0Pkin+Pke4FR5qXvX8MLWhmRAJNG+Jc3AsT15+D8Csv3OADm3PfBNDBHD4AeOcOfFej3FHYC4VEC1hw3WH6WKCmdtN/masyZmHPV+PyKVOgBwubslqVm9A4OA3GC+qDmJM74TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758632755; c=relaxed/simple;
	bh=oQMySvgGa4+mOAny3q24Ce7lMpaNWT+0gsm+tLY4VAM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=FsskX1GaWP09e6+LLQWb/lfg1MYswxFVGh+lXyyUSJISBm9zcXKlJnBYjkUOkqIyotZSSIarLuZgruNFhBbOnKNC31nJqroevDJlEvZoT4fAzniBTqoYNYTM8YYF1rx79l7AoIzTEZaLJJnVjwtnLyRLZvjP8bK4ahVEXDhS+0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=luTJk2sN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="luTJk2sN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D115C4CEF5;
	Tue, 23 Sep 2025 13:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758632755;
	bh=oQMySvgGa4+mOAny3q24Ce7lMpaNWT+0gsm+tLY4VAM=;
	h=Date:From:To:Cc:Subject:References:From;
	b=luTJk2sNjpTifGvz8vUq+lURwsLbIQZ7y9NznP4dt+s3oGocAJKm6fPIPL7/O8BuD
	 C+znQV2Dw9rFnk4O5J5uafpuu0PInnh9da2WosDyYB8fv47n2TRnEnUKjope7cFhbp
	 0h64pTyYifPid9L1XmXvcUDDxyTp5lE268SwaleHRpndBZUdsd3NScXZkd3rmOnr04
	 sGwMdVy3P1YZIoofVOwdXzYPpIucnzhaU6zyrzvZP/+GqPq9hbsDcBkq40GDjc6Hsc
	 BGq09fAqDHAw3sjWFhXO1h4HBV0ql2YVnKqpzLYcbdy8WLnw3CtIGdio0sGfvw5WKD
	 pJIOEzvZgH3Bg==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1v12ji-0000000Cosb-3qR3;
	Tue, 23 Sep 2025 09:07:14 -0400
Message-ID: <20250923130714.766397031@kernel.org>
User-Agent: quilt/0.68
Date: Tue, 23 Sep 2025 09:05:05 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Takaya Saeki <takayas@google.com>,
 Tom Zanussi <zanussi@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Ian Rogers <irogers@google.com>,
 Douglas Raillard <douglas.raillard@arm.com>
Subject: [PATCH v2 8/8] tracing: Show printable characters in syscall arrays
References: <20250923130457.901085554@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

When displaying the contents of the user space data passed to the kernel,
instead of just showing the array values, also print any printable
content.

Instead of just:

  bash-1113    [003] .....  3433.290654: sys_write(fd: 2, buf: 0x555a8deeddb0 (72:6f:6f:74:40:64:65:62:69:61:6e:2d:78:38:36:2d:36:34:3a:7e:23:20), count: 0x16)

Display:

  bash-1113    [003] .....  3433.290654: sys_write(fd: 2, buf: 0x555a8deeddb0 (72:6f:6f:74:40:64:65:62:69:61:6e:2d:78:38:36:2d:36:34:3a:7e:23:20) "root@debian-x86-64:~# ", count: 0x16)

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_syscalls.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index 367e10096c6f..0625a32f01dd 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -155,6 +155,8 @@ print_syscall_enter(struct trace_iterator *iter, int flags,
 	trace_seq_printf(s, "%s(", entry->name);
 
 	for (i = 0; i < entry->nb_args; i++) {
+		bool printable = false;
+		char *str;
 
 		if (trace_seq_has_overflowed(s))
 			goto end;
@@ -193,8 +195,11 @@ print_syscall_enter(struct trace_iterator *iter, int flags,
 
 		val = trace->args[entry->user_arg_size];
 
+		str = ptr;
 		trace_seq_puts(s, " (");
 		for (int x = 0; x < len; x++, ptr++) {
+			if (isascii(*ptr) && isprint(*ptr))
+				printable = true;
 			if (x)
 				trace_seq_putc(s, ':');
 			trace_seq_printf(s, "%02x", *ptr);
@@ -203,6 +208,22 @@ print_syscall_enter(struct trace_iterator *iter, int flags,
 			trace_seq_printf(s, ", %s", EXTRA);
 
 		trace_seq_putc(s, ')');
+
+		/* If nothing is printable, don't bother printing anything */
+		if (!printable)
+			continue;
+
+		trace_seq_puts(s, " \"");
+		for (int x = 0; x < len; x++) {
+			if (isascii(str[x]) && isprint(str[x]))
+				trace_seq_putc(s, str[x]);
+			else
+				trace_seq_putc(s, '.');
+		}
+		if (len < val)
+			trace_seq_printf(s, "\"%s", EXTRA);
+		else
+			trace_seq_putc(s, '"');
 	}
 
 	trace_seq_putc(s, ')');
-- 
2.50.1


