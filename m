Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160B51F09B3;
	Mon, 23 Feb 2026 16:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771863366; cv=none; b=pXN2XHLQGV1SulNSYrM6cLG56qDDo+365GLvZdX9iMxm7RZ7LqYJdW2ZEZSaVhvfgn5k0xF/luhf7EP3h6IApZDWylI01H7J/tBvJyEJ/AfsHsYiTjO17mS8Ykrj+liB6oxdNJr+fyFwMYVaBAZsuicCdheQVmsPb9beAYC+UKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771863366; c=relaxed/simple;
	bh=J0RAcugJGJlSUKCX3gczkJryfiB4Yx2DGk2Ba3Bf5MM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uNva5DEaBgcjIaWy1/5DhuBH92d5RtxVXldITmMMYBqMp6hB9QzK435RT+d8/G26cmwSrBcWkFhGidNR8g/pCszwIIBr9inGQt2WhXRINn1O5dUfmaEew49nElruKRSQW7II60lu8EAgV9KndzyEOE2LisecYA/tH5xMvJIw0dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hN3mI3UV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hN3mI3UV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A85EC116C6;
	Mon, 23 Feb 2026 16:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771863365;
	bh=J0RAcugJGJlSUKCX3gczkJryfiB4Yx2DGk2Ba3Bf5MM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hN3mI3UVcAg5CL6ZZ8VGgfbaNLnBt3c7FcYBDf7SnH7wGLIwfIkWvWd8Vk6mioLr7
	 QZ3/t+RSVJjuCU8HGV6zSSH+uj1OKRnXoOlytI4P8YXeQt00N1APtzxpZl67PIlhiK
	 3jyU3pqTFLK+iaXI13snoS5yS+r0hFxwZs5zLaVDf3diVZV9te98ttmV91RENgQ+oM
	 MJ8KriOJ1TeQUwe8wWJoBV9pau7LO3ROabi0SkPp4A6R/EpTha291wk3xqUvQnlC9e
	 7RCPHayIx19ctQ7P2985S82F2szoahow1F5spZK2k6HUePRDVV1X2McNPo7fSlw+Oh
	 CWvcOKUS9zuqw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] ring-buffer: Flush and stop persistent ring buffer on panic
Date: Tue, 24 Feb 2026 01:16:01 +0900
Message-ID: <177186336156.133407.6100258199357261509.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <177186335195.133407.907308822749006594.stgit@devnote2>
References: <177186335195.133407.907308822749006594.stgit@devnote2>
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
 kernel/trace/ring_buffer.c |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 1e7a34a31851..84a6459ed494 100644
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

