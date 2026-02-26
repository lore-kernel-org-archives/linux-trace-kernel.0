Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB12363C4A;
	Thu, 26 Feb 2026 13:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772113118; cv=none; b=KACXM6p9rvg2l7aJ6mP7K4A0ZXxoxvjdZxS/YCipxiGwkzUtZqCp7vuHz4Drz3EvuioxM/Mayw1zPD3Wj87Qvg3FPf2Zsf1EJJdx12qCILpiBK99iUhWugLN9IrMuqFeDdS2/LEkIAooQwkyAYRwAqNQa3Ue+rbdcl/JbcALXZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772113118; c=relaxed/simple;
	bh=XSg6yRkkFKBKMmH1rJ97eXmWwnKKidYEa2psHsJwUe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dtHVoJW6IU23ek4JXCilRYUMs4HiFV/vRJvnbpVf2VOfk/VEB24QMpfzygsoCYQcZ1UKix+H41VFPLKOwnbtqjE5QHB7DDtyZc/NKFhYcX56Ft9B+57lere3MJ3nQkmZAEIKPtH7LnPa3YaYfgr21TEegpAbupThFDK6I6wD5c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wlw6ixzc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wlw6ixzc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DCF8C116C6;
	Thu, 26 Feb 2026 13:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772113118;
	bh=XSg6yRkkFKBKMmH1rJ97eXmWwnKKidYEa2psHsJwUe4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wlw6ixzc5rlaqrrKfRbC/iDBaIZhzwcUD4ydsBQ7ZoaelObGe+bzQdu08bdxybd6X
	 wbT5wnEvXnBaiQ/MxZSrtiBiYS8stAw9YfKSWwZneosuRZW6sKFOxT77RLVSAYZmGm
	 kNUCx2UVT0ZZ/dKNAVqoSgJA1EXopNN2rJDfRVrkQSefJQoANued8e5uCsYwrHW4fb
	 GknBrQGbwVv6Uu8OEffBxx1tYC31ZhyYv+/TomR44s/NtQPoMNfO2KOIDvqkrXyEX5
	 ZT6iAVf2eoBTlU4ZFWXyN6aleZcusRBVRtZdl3OLwKx5vWXahPZmkBqS36C1FM4F56
	 XIw5smRHvnZjQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v5 1/3] ring-buffer: Flush and stop persistent ring buffer on panic
Date: Thu, 26 Feb 2026 22:38:36 +0900
Message-ID:  <177211311593.419230.2212568977306190482.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
In-Reply-To:  <177211310553.419230.7846100548994399256.stgit@mhiramat.tok.corp.google.com>
References:  <177211310553.419230.7846100548994399256.stgit@mhiramat.tok.corp.google.com>
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
 Changes in v5:
   - Use ring_buffer_record_off() instead of ring_buffer_record_disable().
   - Use flush_cache_all() to ensure flush all cache.
 Changes in v3:
   - update patch description.
---
 kernel/trace/ring_buffer.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index f16f053ef77d..0eb6e6595f37 100644
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
 
@@ -2471,6 +2473,15 @@ static void rb_free_cpu_buffer(struct ring_buffer_per_cpu *cpu_buffer)
 	kfree(cpu_buffer);
 }
 
+static int rb_flush_buffer_cb(struct notifier_block *nb, unsigned long event, void *data)
+{
+	struct trace_buffer *buffer = container_of(nb, struct trace_buffer, flush_nb);
+
+	ring_buffer_record_off(buffer);
+	flush_cache_all();
+	return NOTIFY_DONE;
+}
+
 static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
 					 int order, unsigned long start,
 					 unsigned long end,
@@ -2590,6 +2601,12 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
 
 	mutex_init(&buffer->mutex);
 
+	/* Persistent ring buffer needs to flush cache before reboot. */
+	if (start & end) {
+		buffer->flush_nb.notifier_call = rb_flush_buffer_cb;
+		atomic_notifier_chain_register(&panic_notifier_list, &buffer->flush_nb);
+	}
+
 	return_ptr(buffer);
 
  fail_free_buffers:
@@ -2677,6 +2694,9 @@ ring_buffer_free(struct trace_buffer *buffer)
 {
 	int cpu;
 
+	if (buffer->range_addr_start && buffer->range_addr_end)
+		atomic_notifier_chain_unregister(&panic_notifier_list, &buffer->flush_nb);
+
 	cpuhp_state_remove_instance(CPUHP_TRACE_RB_PREPARE, &buffer->node);
 
 	irq_work_sync(&buffer->irq_work.work);

