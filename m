Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522EC749D
	for <linux-trace-kernel@vger.kernel.org>; Sat,  9 Dec 2023 22:56:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3089EC433C7;
	Sat,  9 Dec 2023 22:56:41 +0000 (UTC)
Date: Sat, 9 Dec 2023 17:57:16 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH] tracing: Increase size of trace_marker_raw to max ring
 buffer entry
Message-ID: <20231209175716.09ac455b@gandalf.local.home>
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

There's no reason to give an arbitrary limit to the size of a raw trace
marker. Just let it be as big as the size that is allowed by the ring
buffer itself.

And there's also no reason to artificially break up the write to
TRACE_BUF_SIZE, as that's not even used.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
[
  Depends on: https://lore.kernel.org/linux-trace-kernel/20231209175003.63db40ab@gandalf.local.home/
]
 kernel/trace/trace.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index da837119a446..077b20e83e7c 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7351,9 +7351,6 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
 	return written;
 }
 
-/* Limit it for now to 3K (including tag) */
-#define RAW_DATA_MAX_SIZE (1024*3)
-
 static ssize_t
 tracing_mark_raw_write(struct file *filp, const char __user *ubuf,
 					size_t cnt, loff_t *fpos)
@@ -7375,18 +7372,16 @@ tracing_mark_raw_write(struct file *filp, const char __user *ubuf,
 		return -EINVAL;
 
 	/* The marker must at least have a tag id */
-	if (cnt < sizeof(unsigned int) || cnt > RAW_DATA_MAX_SIZE)
+	if (cnt < sizeof(unsigned int))
 		return -EINVAL;
 
-	if (cnt > TRACE_BUF_SIZE)
-		cnt = TRACE_BUF_SIZE;
-
-	BUILD_BUG_ON(TRACE_BUF_SIZE >= PAGE_SIZE);
-
 	size = sizeof(*entry) + cnt;
 	if (cnt < FAULT_SIZE_ID)
 		size += FAULT_SIZE_ID - cnt;
 
+	if (size > ring_buffer_max_event_size(buffer))
+		return -EINVAL;
+
 	buffer = tr->array_buffer.buffer;
 	event = __trace_buffer_lock_reserve(buffer, TRACE_RAW_DATA, size,
 					    tracing_gen_ctx());
-- 
2.42.0

