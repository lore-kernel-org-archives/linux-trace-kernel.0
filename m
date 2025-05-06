Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C7128315F;
	Tue,  6 May 2025 14:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746543084; cv=none; b=eugolpCzhcx1qVGJrzS27j6wJqCihlGAUgNPuS98bk6OOuJpS6gVEpKVK//Wgs+/YqSHGo3vEsh3vQgBukteMdAARgYr+0YaY635lfzeKTgGuFLaaTZxhO1nshbsUy6QqOmviZA/Xhcx5RYrbfzTNpDJwZIoDTisKQ/jJ6SdrCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746543084; c=relaxed/simple;
	bh=pAsmGsW9YcfXJtyeY9EsaeMlr5KTBGl5Wjrx9RLKc3I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=tUJhTCU50LoCV6fiCkqIfj8JJed1EzO+75Y+LgFg2Fk5f5oRQiXZV5/JKJyX9YZ3BA/8srong2oYqKy42jcVkvO3JKmhL9oIhRFGmgznnFHdDUHw/XUoCCq9DtF1vdH6hxEYEiqySL28RE9lVGqRaoIYv2Ch4gLGzd654ZLgijc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B555DC4CEEB;
	Tue,  6 May 2025 14:51:23 +0000 (UTC)
Date: Tue, 6 May 2025 10:51:31 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] tracing: Show preempt and irq events callsites from the
 offsets in field print
Message-ID: <20250506105131.4b6089a9@gandalf.local.home>
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

When the "fields" option is set in a trace instance, it ignores the "print fmt"
portion of the trace event and just prints the raw fields defined by the
TP_STRUCT__entry() of the TRACE_EVENT() macro.

The preempt_disable/enable and irq_disable/enable events record only the
caller offset from _stext to save space in the ring buffer. Even though
the "fields" option only prints the fields, it also tries to print what
they represent too, which includes function names.

Add a check in the output of the event field printing to see if the field
name is "caller_offs" or "parent_offs" and then print the function at the
offset from _stext of that field.

Instead of just showing:

  irq_disable: caller_offs=0xba634d (12215117) parent_offs=0x39d10e2 (60625122)

Show:

  irq_disable: caller_offs=trace_hardirqs_off.part.0+0xad/0x130 0xba634d (12215117) parent_offs=_raw_spin_lock_irqsave+0x62/0x70 0x39d10e2 (60625122)

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_output.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index aa0d3663f754..9bf40fa84bb5 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -1019,6 +1019,17 @@ static void print_fields(struct trace_iterator *iter, struct trace_event_call *c
 				}
 
 				addr = *(unsigned int *)pos;
+
+				/* Some fields reference offset from _stext. */
+				if (!strcmp(field->name, "caller_offs") ||
+				    !strcmp(field->name, "parent_offs")) {
+					unsigned long ip;
+
+					ip = addr + (unsigned long)_stext;
+					ip = trace_adjust_address(tr, ip);
+					trace_seq_printf(&iter->seq, "%pS ", (void *)ip);
+				}
+
 				if (sizeof(long) == 4) {
 					addr = trace_adjust_address(tr, addr);
 					trace_seq_printf(&iter->seq, "%pS (%d)",
-- 
2.47.2

