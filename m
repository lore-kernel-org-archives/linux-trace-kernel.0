Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D76F11CAD
	for <linux-trace-kernel@vger.kernel.org>; Mon, 11 Dec 2023 03:12:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C81DCC433C8;
	Mon, 11 Dec 2023 03:12:51 +0000 (UTC)
Date: Sun, 10 Dec 2023 22:12:50 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH] ring-buffer: Fix memory leak of free page
Message-ID: <20231210221250.7b9cc83c@rorschach.local.home>
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

Reading the ring buffer does a swap of a sub-buffer within the ring buffer
with a empty sub-buffer. This allows the reader to have full access to the
content of the sub-buffer that was swapped out without having to worry
about contention with the writer.

The readers call ring_buffer_alloc_read_page() to allocate a page that
will be used to swap with the ring buffer. When the code is finished with
the reader page, it calls ring_buffer_free_read_page(). Instead of freeing
the page, it stores it as a spare. Then next call to
ring_buffer_alloc_read_page() will return this spare instead of calling
into the memory management system to allocate a new page.

Unfortunately, on freeing of the ring buffer, this spare page is not
freed, and causes a memory leak.

Cc: stable@vger.kernel.org
Fixes: 73a757e63114d ("ring-buffer: Return reader page back into existing ring buffer")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index a38e5a3c6803..dd37d21d6e55 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1790,6 +1790,8 @@ static void rb_free_cpu_buffer(struct ring_buffer_per_cpu *cpu_buffer)
 		free_buffer_page(bpage);
 	}
 
+	free_page((unsigned long)cpu_buffer->free_page);
+
 	kfree(cpu_buffer);
 }
 
-- 
2.42.0

