Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856FF516F4
	for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Sep 2023 22:01:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1534C433C9;
	Fri, 29 Sep 2023 22:01:17 +0000 (UTC)
Date: Fri, 29 Sep 2023 18:01:13 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Julia Lawall <Julia.Lawall@inria.fr>
Subject: [PATCH] ring-buffer: Update "shortest_full" in polling
Message-ID: <20230929180113.01c2cae3@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

It was discovered that the ring buffer polling was incorrectly stating
that read would not block, but that's because polling did not take into
account that reads will block if the "buffer-percent" was set. Instead,
the ring buffer polling would say reads would not block if there was any
data in the ring buffer. This was incorrect behavior from a user space
point of view. This was fixed by commit 42fb0a1e84ff by having the polling
code check if the ring buffer had more data than what the user specified
"buffer percent" had.

The problem now is that the polling code did not register itself to the
writer that it wanted to wait for a specific "full" value of the ring
buffer. The result was that the writer would wake the polling waiter
whenever there was a new event. The polling waiter would then wake up, see
that there's not enough data in the ring buffer to notify user space and
then go back to sleep. The next event would wake it up again.

Before the polling fix was added, the code would wake up around 100 times
for a hackbench 30 benchmark. After the "fix", due to the constant waking
of the writer, it would wake up over 11,0000 times! It would never leave
the kernel, so the user space behavior was still "correct", but this
definitely is not the desired effect.

To fix this, have the polling code add what it's waiting for to the
"shortest_full" variable, to tell the writer not to wake it up if the
buffer is not as full as it expects to be.

Note, after this fix, it appears that the waiter is now woken up around 2x
the times it was before (~200). This is a tremendous improvement from the
11,000 times, but I will need to spend some time to see why polling is
more aggressive in its wakeups than the read blocking code.

Cc: stable@vger.kernel.org
Fixes: 42fb0a1e84ff ("tracing/ring-buffer: Have polling block on watermark")
Reported-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 28daf0ce95c5..515cafdb18d9 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1137,6 +1137,9 @@ __poll_t ring_buffer_poll_wait(struct trace_buffer *buffer, int cpu,
 	if (full) {
 		poll_wait(filp, &work->full_waiters, poll_table);
 		work->full_waiters_pending = true;
+		if (!cpu_buffer->shortest_full ||
+		    cpu_buffer->shortest_full > full)
+			cpu_buffer->shortest_full = full;
 	} else {
 		poll_wait(filp, &work->waiters, poll_table);
 		work->waiters_pending = true;
-- 
2.40.1

