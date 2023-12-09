Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AEC1EA7E
	for <linux-trace-kernel@vger.kernel.org>; Sat,  9 Dec 2023 22:51:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0731FC433C9;
	Sat,  9 Dec 2023 22:51:44 +0000 (UTC)
Date: Sat, 9 Dec 2023 17:52:20 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH] trace_seq: Increase the buffer size to almost two pages
Message-ID: <20231209175220.19867af4@gandalf.local.home>
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

Now that trace_marker can hold more than 1KB string, and can write as much
as the ring buffer can hold, the trace_seq is not big enough to hold
writes:

 ~# a="1234567890"
 ~# cnt=4080
 ~# s=""
 ~# while [ $cnt -gt 10 ]; do
 ~#	s="${s}${a}"
 ~#	cnt=$((cnt-10))
 ~# done
 ~# echo $s > trace_marker
 ~# cat trace
 # tracer: nop
 #
 # entries-in-buffer/entries-written: 2/2   #P:8
 #
 #                                _-----=> irqs-off/BH-disabled
 #                               / _----=> need-resched
 #                              | / _---=> hardirq/softirq
 #                              || / _--=> preempt-depth
 #                              ||| / _-=> migrate-disable
 #                              |||| /     delay
 #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
 #              | |         |   |||||     |         |
            <...>-860     [002] .....   105.543465: tracing_mark_write[LINE TOO BIG]
            <...>-860     [002] .....   105.543496: tracing_mark_write: 789012345678901234567890

By increasing the trace_seq buffer to almost two pages, it can now print
out the first line.

This also subtracts the rest of the trace_seq fields from the buffer, so
that the entire trace_seq is now PAGE_SIZE aligned.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/trace_seq.h | 9 ++++++---
 kernel/trace/trace.c      | 6 +++---
 kernel/trace/trace_seq.c  | 3 ---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/trace_seq.h b/include/linux/trace_seq.h
index 3691e0e76a1a..9ec229dfddaa 100644
--- a/include/linux/trace_seq.h
+++ b/include/linux/trace_seq.h
@@ -8,11 +8,14 @@
 
 /*
  * Trace sequences are used to allow a function to call several other functions
- * to create a string of data to use (up to a max of PAGE_SIZE).
+ * to create a string of data to use.
  */
 
+#define TRACE_SEQ_BUFFER_SIZE	(PAGE_SIZE * 2 - \
+	(sizeof(struct seq_buf) + sizeof(size_t) + sizeof(int)))
+
 struct trace_seq {
-	char			buffer[PAGE_SIZE];
+	char			buffer[TRACE_SEQ_BUFFER_SIZE];
 	struct seq_buf		seq;
 	size_t			readpos;
 	int			full;
@@ -21,7 +24,7 @@ struct trace_seq {
 static inline void
 trace_seq_init(struct trace_seq *s)
 {
-	seq_buf_init(&s->seq, s->buffer, PAGE_SIZE);
+	seq_buf_init(&s->seq, s->buffer, TRACE_SEQ_BUFFER_SIZE);
 	s->full = 0;
 	s->readpos = 0;
 }
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 83393c65ec71..da837119a446 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3753,7 +3753,7 @@ static bool trace_safe_str(struct trace_iterator *iter, const char *str,
 
 	/* OK if part of the temp seq buffer */
 	if ((addr >= (unsigned long)iter->tmp_seq.buffer) &&
-	    (addr < (unsigned long)iter->tmp_seq.buffer + PAGE_SIZE))
+	    (addr < (unsigned long)iter->tmp_seq.buffer + TRACE_SEQ_BUFFER_SIZE))
 		return true;
 
 	/* Core rodata can not be freed */
@@ -6926,8 +6926,8 @@ tracing_read_pipe(struct file *filp, char __user *ubuf,
 		goto out;
 	}
 
-	if (cnt >= PAGE_SIZE)
-		cnt = PAGE_SIZE - 1;
+	if (cnt >= TRACE_SEQ_BUFFER_SIZE)
+		cnt = TRACE_SEQ_BUFFER_SIZE - 1;
 
 	/* reset all but tr, trace, and overruns */
 	trace_iterator_reset(iter);
diff --git a/kernel/trace/trace_seq.c b/kernel/trace/trace_seq.c
index 7be97229ddf8..c158d65a8a88 100644
--- a/kernel/trace/trace_seq.c
+++ b/kernel/trace/trace_seq.c
@@ -13,9 +13,6 @@
  * trace_seq_init() more than once to reset the trace_seq to start
  * from scratch.
  * 
- * The buffer size is currently PAGE_SIZE, although it may become dynamic
- * in the future.
- *
  * A write to the buffer will either succeed or fail. That is, unlike
  * sprintf() there will not be a partial write (well it may write into
  * the buffer but it wont update the pointers). This allows users to
-- 
2.42.0

