Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5536130FB9
	for <linux-trace-kernel@vger.kernel.org>; Wed,  6 Dec 2023 15:02:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD1CC433C7;
	Wed,  6 Dec 2023 15:02:16 +0000 (UTC)
Date: Wed, 6 Dec 2023 10:02:44 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH] ring-buffer: Force absolute timestamp on discard of event
Message-ID: <20231206100244.5130f9b3@gandalf.local.home>
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

There's a race where if an event is discarded from the ring buffer and an
interrupt were to happen at that time and insert an event, the time stamp
is still used from the discarded event as an offset. This can screw up the
timings.

If the event is going to be discarded, set the "before_stamp" to zero.
When a new event comes in, it compares the "before_stamp" with the
"write_stamp" and if they are not equal, it will insert an absolute
timestamp. This will prevent the timings from getting out of sync due to
the discarded event.

Cc: stable@vger.kernel.org
Fixes: 6f6be606e763f ("ring-buffer: Force before_stamp and write_stamp to be different on discard")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 43cc47d7faaf..a6da2d765c78 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3030,22 +3030,19 @@ rb_try_to_discard(struct ring_buffer_per_cpu *cpu_buffer,
 			local_read(&bpage->write) & ~RB_WRITE_MASK;
 		unsigned long event_length = rb_event_length(event);
 
+		/*
+		 * For the before_stamp to be different than the write_stamp
+		 * to make sure that the next event adds an absolute
+		 * value and does not rely on the saved write stamp, which
+		 * is now going to be bogus.
+		 */
+		rb_time_set(&cpu_buffer->before_stamp, 0);
+
 		/* Something came in, can't discard */
 		if (!rb_time_cmpxchg(&cpu_buffer->write_stamp,
 				       write_stamp, write_stamp - delta))
 			return false;
 
-		/*
-		 * It's possible that the event time delta is zero
-		 * (has the same time stamp as the previous event)
-		 * in which case write_stamp and before_stamp could
-		 * be the same. In such a case, force before_stamp
-		 * to be different than write_stamp. It doesn't
-		 * matter what it is, as long as its different.
-		 */
-		if (!delta)
-			rb_time_set(&cpu_buffer->before_stamp, 0);
-
 		/*
 		 * If an event were to come in now, it would see that the
 		 * write_stamp and the before_stamp are different, and assume
-- 
2.42.0

