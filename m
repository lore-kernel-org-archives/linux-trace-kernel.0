Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC466128
	for <linux-trace-kernel@vger.kernel.org>; Mon, 11 Dec 2023 16:43:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D78BC433C8;
	Mon, 11 Dec 2023 16:43:41 +0000 (UTC)
Date: Mon, 11 Dec 2023 11:44:20 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH] ring-buffer: Do not update before stamp when switching
 sub-buffers
Message-ID: <20231211114420.36dde01b@gandalf.local.home>
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

The ring buffer timestamps are synchronized by two timestamp placeholders.
One is the "before_stamp" and the other is the "write_stamp" (sometimes
referred to as the "after stamp" but only in the comments. These two
stamps are key to knowing how to handle nested events coming in with a
lockless system.

When moving across sub-buffers, the before stamp is updated but the write
stamp is not. There's an effort to put back the before stamp to something
that seems logical in case there's nested events. But as the current event
is about to cross sub-buffers, and so will any new nested event that happens,
updating the before stamp is useless, and could even introduce new race
conditions.

The first event on a sub-buffer simply uses the sub-buffer's timestamp
and keeps a "delta" of zero. The "before_stamp" and "write_stamp" are not
used in the algorithm in this case. There's no reason to try to fix the
before_stamp when this happens.

As a bonus, it removes a cmpxchg() when crossing sub-buffers!

Cc: stable@vger.kernel.org
Fixes: a389d86f7fd09 ("ring-buffer: Have nested events still record running time stamp")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 2596fa7b748a..02bc9986fe0d 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3607,14 +3607,7 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 
 	/* See if we shot pass the end of this buffer page */
 	if (unlikely(write > BUF_PAGE_SIZE)) {
-		/* before and after may now different, fix it up*/
-		b_ok = rb_time_read(&cpu_buffer->before_stamp, &info->before);
-		a_ok = rb_time_read(&cpu_buffer->write_stamp, &info->after);
-		if (a_ok && b_ok && info->before != info->after)
-			(void)rb_time_cmpxchg(&cpu_buffer->before_stamp,
-					      info->before, info->after);
-		if (a_ok && b_ok)
-			check_buffer(cpu_buffer, info, CHECK_FULL_PAGE);
+		check_buffer(cpu_buffer, info, CHECK_FULL_PAGE);
 		return rb_move_tail(cpu_buffer, tail, info);
 	}
 
-- 
2.42.0

