Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A0F59540
	for <linux-trace-kernel@vger.kernel.org>; Wed, 13 Dec 2023 18:20:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2601AC433CC;
	Wed, 13 Dec 2023 18:20:37 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rDTrG-00000002a6J-20UT;
	Wed, 13 Dec 2023 13:21:22 -0500
Message-ID: <20231213182122.260163713@goodmis.org>
User-Agent: quilt/0.67
Date: Wed, 13 Dec 2023 13:17:38 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
 Vincent Donnefort <vdonnefort@google.com>,
 Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH v3 01/15] ring-buffer: Refactor ring buffer implementation
References: <20231213181737.791847466@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>

In order to introduce sub-buffer size per ring buffer, some internal
refactoring is needed. As ring_buffer_print_page_header() will depend on
the trace_buffer structure, it is moved after the structure definition.

Link: https://lore.kernel.org/linux-trace-devel/20211213094825.61876-2-tz.stoyanov@gmail.com

Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 60 +++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 8f8887f025c9..eee36f90ae25 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -378,36 +378,6 @@ static inline bool test_time_stamp(u64 delta)
 /* Max payload is BUF_PAGE_SIZE - header (8bytes) */
 #define BUF_MAX_DATA_SIZE (BUF_PAGE_SIZE - (sizeof(u32) * 2))
 
-int ring_buffer_print_page_header(struct trace_seq *s)
-{
-	struct buffer_data_page field;
-
-	trace_seq_printf(s, "\tfield: u64 timestamp;\t"
-			 "offset:0;\tsize:%u;\tsigned:%u;\n",
-			 (unsigned int)sizeof(field.time_stamp),
-			 (unsigned int)is_signed_type(u64));
-
-	trace_seq_printf(s, "\tfield: local_t commit;\t"
-			 "offset:%u;\tsize:%u;\tsigned:%u;\n",
-			 (unsigned int)offsetof(typeof(field), commit),
-			 (unsigned int)sizeof(field.commit),
-			 (unsigned int)is_signed_type(long));
-
-	trace_seq_printf(s, "\tfield: int overwrite;\t"
-			 "offset:%u;\tsize:%u;\tsigned:%u;\n",
-			 (unsigned int)offsetof(typeof(field), commit),
-			 1,
-			 (unsigned int)is_signed_type(long));
-
-	trace_seq_printf(s, "\tfield: char data;\t"
-			 "offset:%u;\tsize:%u;\tsigned:%u;\n",
-			 (unsigned int)offsetof(typeof(field), data),
-			 (unsigned int)BUF_PAGE_SIZE,
-			 (unsigned int)is_signed_type(char));
-
-	return !trace_seq_has_overflowed(s);
-}
-
 struct rb_irq_work {
 	struct irq_work			work;
 	wait_queue_head_t		waiters;
@@ -573,6 +543,36 @@ struct ring_buffer_iter {
 	int				missed_events;
 };
 
+int ring_buffer_print_page_header(struct trace_seq *s)
+{
+	struct buffer_data_page field;
+
+	trace_seq_printf(s, "\tfield: u64 timestamp;\t"
+			 "offset:0;\tsize:%u;\tsigned:%u;\n",
+			 (unsigned int)sizeof(field.time_stamp),
+			 (unsigned int)is_signed_type(u64));
+
+	trace_seq_printf(s, "\tfield: local_t commit;\t"
+			 "offset:%u;\tsize:%u;\tsigned:%u;\n",
+			 (unsigned int)offsetof(typeof(field), commit),
+			 (unsigned int)sizeof(field.commit),
+			 (unsigned int)is_signed_type(long));
+
+	trace_seq_printf(s, "\tfield: int overwrite;\t"
+			 "offset:%u;\tsize:%u;\tsigned:%u;\n",
+			 (unsigned int)offsetof(typeof(field), commit),
+			 1,
+			 (unsigned int)is_signed_type(long));
+
+	trace_seq_printf(s, "\tfield: char data;\t"
+			 "offset:%u;\tsize:%u;\tsigned:%u;\n",
+			 (unsigned int)offsetof(typeof(field), data),
+			 (unsigned int)BUF_PAGE_SIZE,
+			 (unsigned int)is_signed_type(char));
+
+	return !trace_seq_has_overflowed(s);
+}
+
 #ifdef RB_TIME_32
 
 /*
-- 
2.42.0


