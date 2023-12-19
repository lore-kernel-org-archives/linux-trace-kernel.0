Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6996B3B296;
	Tue, 19 Dec 2023 18:55:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 531C6C433CC;
	Tue, 19 Dec 2023 18:55:31 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rFfGY-00000003R4q-3frI;
	Tue, 19 Dec 2023 13:56:30 -0500
Message-ID: <20231219185630.649397785@goodmis.org>
User-Agent: quilt/0.67
Date: Tue, 19 Dec 2023 13:54:25 -0500
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
Subject: [PATCH v5 11/15] ring-buffer: Keep the same size when updating the order
References: <20231219185414.474197117@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The function ring_buffer_subbuf_order_set() just updated the sub-buffers
to the new size, but this also changes the size of the buffer in doing so.
As the size is determined by nr_pages * subbuf_size. If the subbuf_size is
increased without decreasing the nr_pages, this causes the total size of
the buffer to increase.

This broke the latency tracers as the snapshot needs to be the same size
as the main buffer. The size of the snapshot buffer is only expanded when
needed, and because the order is still the same, the size becomes out of
sync with the main buffer, as the main buffer increased in size without
the tracing system knowing.

Calculate the nr_pages to allocate with the new subbuf_size to be
buffer_size / new_subbuf_size.

Fixes: TBD ("ring-buffer: Set new size of the ring buffer sub page")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index fdcd171b09b5..23ead7602da0 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5897,7 +5897,10 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 		if (!cpumask_test_cpu(cpu, buffer->cpumask))
 			continue;
 
-		nr_pages = buffer->buffers[cpu]->nr_pages;
+		/* Update the number of pages to match the new size */
+		nr_pages = old_size * buffer->buffers[cpu]->nr_pages;
+		nr_pages = DIV_ROUND_UP(nr_pages, buffer->subbuf_size);
+
 		cpu_buffers[cpu] = rb_allocate_cpu_buffer(buffer, nr_pages, cpu);
 		if (!cpu_buffers[cpu]) {
 			err = -ENOMEM;
-- 
2.42.0


