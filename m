Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178762F12AF;
	Tue, 24 Feb 2026 06:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771915965; cv=none; b=EkDeu70x8/Lh9HWGvYDzOi8gay1ODohXXjAl64UBVLDNp8d2OeLim0C+culn+r88EP6DOSh97/1nOtJskPvNZpVHOALNbm1i6NuiXt+evl+oXEG2CaYdRTniPooeZNOEdlgXQ3dt+KbOSkinG9kNSFz62S6tmhcDsAvi4RsgFK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771915965; c=relaxed/simple;
	bh=gypdpJkmcV6D/oJuk2s7QT1S/EzyTDFnk0l2rLqc3+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z0SY26iVXHY0Ycnx1QEPugkc9kMtHHr3Msgj4xugsFZMJuHVg46+k3aj+yF8Q04eTVwZ3O2Tpsr0kIOO3Dh0IGp9viaGzOAikrKVtVfoXH+dBwB8AYQnyVigu1dOJ8X99ClnIsmrjRhOtZBVx1axzjfy/V8vUhsBHt+sNfNjbPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rwIVbHOC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rwIVbHOC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECEEEC116D0;
	Tue, 24 Feb 2026 06:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771915964;
	bh=gypdpJkmcV6D/oJuk2s7QT1S/EzyTDFnk0l2rLqc3+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rwIVbHOCu4jNOt09DFeazLcwRxXkxkNUGUWHXEVkjk5DJdsgF/BNwER5iRimIK7v3
	 M3J3tFZ5tQezlfGttzWprvfMdua8ZxxwI3yXzdKUJQQlcnXEVNyDbdUIBb9OFjMcgX
	 BR33/csPTXYgBTxROSWBaRxN+M1WvCZClHJJC0feqpGNjy2wiF0DZhRezTtT5TmoP+
	 dIEU66uKrCI9iWe4FwHVqIkqcFhp6AAITcjq18qoTsOuVnnswNSAFD0KpVc4gufqzy
	 i21Q0mXIH2+/h+qmdJTIwsC/m8NCoLexsDiBI4YCNWKCN9xFYEQefU8BbVeckJCN3o
	 dYjxSahPMkJ4Q==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] ring-buffer: Flush and stop persistent ring buffer on panic
Date: Tue, 24 Feb 2026 15:52:42 +0900
Message-ID:  <177191596224.435720.8250761603256925623.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.53.0.371.g1d285c8824-goog
In-Reply-To:  <177191595057.435720.10116014529518464418.stgit@mhiramat.tok.corp.google.com>
References:  <177191595057.435720.10116014529518464418.stgit@mhiramat.tok.corp.google.com>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

On real hardware, panic and machine reboot may not flush hardware cache
to memory. This means the persistent ring buffer, which relies on a
coherent state of memory, may not have its events written to the buffer
and they may be lost. Moreover, there may be inconsistency with the
counters which are used for validation of the integrity of the
persistent ring buffer which may cause all data to be discarded.

To avoid this issue, stop recording of the ring buffer on panic and
flush the cache of the ring buffer's memory.

Fixes: e645535a954a ("tracing: Add option to use memmapped memory for trace boot instance")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v3:
   - update patch description.
---
 kernel/trace/ring_buffer.c |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index f16f053ef77d..3eb124c93d72 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6,6 +6,7 @@
  */
 #include <linux/sched/isolation.h>
 #include <linux/trace_recursion.h>
+#include <linux/panic_notifier.h>
 #include <linux/trace_events.h>
 #include <linux/ring_buffer.h>
 #include <linux/trace_clock.h>
@@ -589,6 +590,7 @@ struct trace_buffer {
 
 	unsigned long			range_addr_start;
 	unsigned long			range_addr_end;
+	struct notifier_block		flush_nb;
 
 	struct ring_buffer_meta		*meta;
 
@@ -2471,6 +2473,16 @@ static void rb_free_cpu_buffer(struct ring_buffer_per_cpu *cpu_buffer)
 	kfree(cpu_buffer);
 }
 
+static int rb_flush_buffer_cb(struct notifier_block *nb, unsigned long event, void *data)
+{
+	struct trace_buffer *buffer = container_of(nb, struct trace_buffer, flush_nb);
+
+	ring_buffer_record_disable(buffer);
+	flush_kernel_vmap_range((void *)buffer->range_addr_start,
+				buffer->range_addr_end - buffer->range_addr_start);
+	return NOTIFY_DONE;
+}
+
 static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
 					 int order, unsigned long start,
 					 unsigned long end,
@@ -2590,6 +2602,12 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
 
 	mutex_init(&buffer->mutex);
 
+	/* Persistent ring buffer needs to flush cache before reboot. */
+	if (start & end) {
+		buffer->flush_nb.notifier_call = rb_flush_buffer_cb;
+		atomic_notifier_chain_register(&panic_notifier_list, &buffer->flush_nb);
+	}
+
 	return_ptr(buffer);
 
  fail_free_buffers:
@@ -2677,6 +2695,9 @@ ring_buffer_free(struct trace_buffer *buffer)
 {
 	int cpu;
 
+	if (buffer->range_addr_start && buffer->range_addr_end)
+		atomic_notifier_chain_unregister(&panic_notifier_list, &buffer->flush_nb);
+
 	cpuhp_state_remove_instance(CPUHP_TRACE_RB_PREPARE, &buffer->node);
 
 	irq_work_sync(&buffer->irq_work.work);

