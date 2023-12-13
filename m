Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B585199
	for <linux-trace-kernel@vger.kernel.org>; Wed, 13 Dec 2023 00:03:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 110CAC433C7;
	Wed, 13 Dec 2023 00:03:39 +0000 (UTC)
Date: Tue, 12 Dec 2023 19:04:22 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH] tracing: Have trace_marker break up by lines by size of
 trace_seq
Message-ID: <20231212190422.1eaf224f@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

If a trace_marker write is bigger than what trace_seq can hold, then it
will print "LINE TOO BIG" message and not what was written.

Instead, if check if the write is bigger than the trace_seq and break it
up by that size.

Ideally, we could make the trace_seq dynamic that could hold this. But
that's for another time.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 893e749713d3..2a21bc840fe7 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7298,6 +7298,11 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
 	if (cnt < FAULTED_SIZE)
 		size += FAULTED_SIZE - cnt;
 
+	if (size > TRACE_SEQ_BUFFER_SIZE) {
+		cnt -= size - TRACE_SEQ_BUFFER_SIZE;
+		goto again;
+	}
+
 	buffer = tr->array_buffer.buffer;
 	event = __trace_buffer_lock_reserve(buffer, TRACE_PRINT, size,
 					    tracing_gen_ctx());
-- 
2.42.0

