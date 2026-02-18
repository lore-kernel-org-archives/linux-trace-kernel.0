Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31EC327C07;
	Wed, 18 Feb 2026 10:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771409670; cv=none; b=glO6OddPUW9kqhyDmnf2Vj0ZwFoHMH8QOf1UQdJBucuJeHj1Wnnk3dtP8PvChjOaa0L9nCIu+/kHrEttC3IiXaCxgSEMuroKgFD+czkxP+hh4adh6FR4iyylw+a2Kulr+gGcKqY7jxn7HLu8MLnrPDLiUdOZHDDxsaqDoQtFTg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771409670; c=relaxed/simple;
	bh=R7GzyDgg902KswZrSYt8lGNc9Yf1SqV4/2OamG2lcZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=liL9Dd8uLcMPEyRUpxBz0vvpAp3eOKoXnsyIcgd/cEirrD3bKQkshDEhVgLvjXi1nwvWFwzD+a6LPxhJZAs5z1sd6OULP9g+XOj9BgO/hNsed/ewZ4fEdPITDk+r5unhq//a2UpuA0iOW030UOcXBqchNmXZAFu7TcvKzPC4dsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWqp6zzF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWqp6zzF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB27CC19421;
	Wed, 18 Feb 2026 10:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771409670;
	bh=R7GzyDgg902KswZrSYt8lGNc9Yf1SqV4/2OamG2lcZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aWqp6zzF/5NifdSv21paqkctSbf2BhGtP8L+G5t0gyAxz1HS/KclLGJ2+pYyhxRLK
	 PQKVPt6Ykj9aW5prSVWwmzbFOIovvKTMDQyyRXB9ow4idKin29MvykUtSTfGn+eZR9
	 OU7k8WW88JZYyJIlnuNbkpIJGoJIJyttcFhi+nBV6z4FL3IvtE2AO3zZ2nYwu9OkES
	 K1VUFoj86SYXHWcopAE86UohStg9GcoS1mZ14KDH1RtVPx0ul+GU4CPKEVy9qQ2jFe
	 kwWXhTfL343hkZjTzJOf9EXzJBJAwKGrqRcBOsqcBNHkIOGI4fdBQsER6XYj2I4jPT
	 ALgLXj1b6D/Eg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] ring-buffer: Flush and stop persistent ring buffer on panic
Date: Wed, 18 Feb 2026 19:14:28 +0900
Message-ID:  <177140966801.1537493.7352910810257662003.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
In-Reply-To:  <177140965047.1537493.15501794841217306382.stgit@mhiramat.tok.corp.google.com>
References:  <177140965047.1537493.15501794841217306382.stgit@mhiramat.tok.corp.google.com>
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

On a real hardware, since panic and reboot the machine will not
flush hardware cache to the persistent ring buffer, the events
written right before the panic can be lost. Moreover, since
there will be an inconsistency between the commit counter (which
is written atomically via local_set()) and the data, validation
will fail and all data in the persistent ring buffer will be lost.

To avoid this issue, this will stop recording on the ring buffer
and flush cache at the reserved memory on panic.

Fixes: e645535a954a ("tracing: Add option to use memmapped memory for trace boot instance")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/ring_buffer.c |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index f7fd4bdf6560..d2b69221a94c 100644
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
 
@@ -2470,6 +2472,16 @@ static void rb_free_cpu_buffer(struct ring_buffer_per_cpu *cpu_buffer)
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
@@ -2589,6 +2601,12 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
 
 	mutex_init(&buffer->mutex);
 
+	/* Persistent ring buffer needs to flush cache before reboot. */
+	if (start & end) {
+		buffer->flush_nb.notifier_call = rb_flush_buffer_cb;
+		atomic_notifier_chain_register(&panic_notifier_list, &buffer->flush_nb);
+	}
+
 	return_ptr(buffer);
 
  fail_free_buffers:
@@ -2676,6 +2694,9 @@ ring_buffer_free(struct trace_buffer *buffer)
 {
 	int cpu;
 
+	if (buffer->range_addr_start && buffer->range_addr_end)
+		atomic_notifier_chain_unregister(&panic_notifier_list, &buffer->flush_nb);
+
 	cpuhp_state_remove_instance(CPUHP_TRACE_RB_PREPARE, &buffer->node);
 
 	irq_work_sync(&buffer->irq_work.work);

