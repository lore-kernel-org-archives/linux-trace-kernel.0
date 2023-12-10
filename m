Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0A517CF
	for <linux-trace-kernel@vger.kernel.org>; Sun, 10 Dec 2023 04:04:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB36C433AB;
	Sun, 10 Dec 2023 04:04:13 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rCB3i-000000021OH-0soF;
	Sat, 09 Dec 2023 23:04:50 -0500
Message-ID: <20231210040449.997493720@goodmis.org>
User-Agent: quilt/0.67
Date: Sat, 09 Dec 2023 22:54:10 -0500
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
Subject: [PATCH 06/14] ring-buffer: Clear pages on error in ring_buffer_subbuf_order_set()
 failure
References: <20231210035404.053677508@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

On failure to allocate ring buffer pages, the pointer to the CPU buffer
pages is freed, but the pages that were allocated previously were not.
Make sure they are freed too.

Fixes: TBD ("tracing: Set new size of the ring buffer sub page")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 4cb03b3b99e6..4e7eb41695f5 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6060,6 +6060,7 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 	for_each_buffer_cpu(buffer, cpu) {
 		if (!cpu_buffers[cpu])
 			continue;
+		rb_free_cpu_buffer(cpu_buffers[cpu]);
 		kfree(cpu_buffers[cpu]);
 	}
 	kfree(cpu_buffers);
-- 
2.42.0


