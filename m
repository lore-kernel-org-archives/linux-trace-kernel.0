Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3725F5DF0E
	for <linux-trace-kernel@vger.kernel.org>; Tue, 12 Dec 2023 12:25:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1468CC433C8;
	Tue, 12 Dec 2023 12:25:16 +0000 (UTC)
Date: Tue, 12 Dec 2023 07:25:58 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH] ring-buffer: Have saved event hold the entire event
Message-ID: <20231212072558.61f76493@gandalf.local.home>
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

For the ring buffer iterator (non-consuming read), the event needs to be
copied into the iterator buffer to make sure that a writer does not
overwrite it while the user is reading it. If a write happens during the
copy, the buffer is simply discarded.

But the temp buffer itself was not big enough. The allocation of the
buffer was only BUF_MAX_DATA_SIZE, which is the maximum data size that can
be passed into the ring buffer and saved. But the temp buffer needs to
hold the meta data as well. That would be BUF_PAGE_SIZE and not
BUF_MAX_DATA_SIZE.

Cc: stable@vger.kernel.org
Fixes: 785888c544e04 ("ring-buffer: Have rb_iter_head_event() handle concurrent writer")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 095b86081ea8..32e41ca41caf 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2409,7 +2409,7 @@ rb_iter_head_event(struct ring_buffer_iter *iter)
 	 */
 	barrier();
 
-	if ((iter->head + length) > commit || length > BUF_MAX_DATA_SIZE)
+	if ((iter->head + length) > commit || length > BUF_PAGE_SIZE)
 		/* Writer corrupted the read? */
 		goto reset;
 
@@ -5115,7 +5115,8 @@ ring_buffer_read_prepare(struct trace_buffer *buffer, int cpu, gfp_t flags)
 	if (!iter)
 		return NULL;
 
-	iter->event = kmalloc(BUF_MAX_DATA_SIZE, flags);
+	/* Holds the entire event: data and meta data */
+	iter->event = kmalloc(BUF_PAGE_SIZE, flags);
 	if (!iter->event) {
 		kfree(iter);
 		return NULL;
-- 
2.42.0

