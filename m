Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96ECD20B804;
	Fri,  2 May 2025 20:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746219229; cv=none; b=KhxPPqNM/7LIRyPzO9UZuPlCF+QCANB/zn3P7UHf1JSd/lNXPuB3FQsE/kOKBongY6s1MEYBTFb/LCbHgvWzscF2x2swi5RdbKQC5znjz2l2ozxfmaaO+B/bjNiHd79fpNEWvGahy9DhALT80ICR71BJSDiPd+C+oqKOtP66tbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746219229; c=relaxed/simple;
	bh=pId5/Jcxvem2yAo/sd/QFa3MIyaShk8NSYQziKIW174=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=cNdyLm4KCFbPuZEpboHZkV0Imh4IDTq5WUKpx2l3GKasrsRRodjeIsvHjkQWN/SevmvHVnDkEz/42L9MgRawpgt8LeJoyQ0yP8RnlspAqGRin05PrxHe+0L021owznw/LPXsvCk0d7cb+wUTJ06RGvCVPv2/WE1+knzENq7nDHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F5D6C4AF0C;
	Fri,  2 May 2025 20:53:49 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uAxOH-000000006D4-1AFQ;
	Fri, 02 May 2025 16:53:49 -0400
Message-ID: <20250502205349.134949967@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 02 May 2025 16:51:55 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 08/12] ring-buffer: Add ring_buffer_record_is_on_cpu()
References: <20250502205147.283272733@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Add the function ring_buffer_record_is_on_cpu() that returns true if the
ring buffer for a give CPU is writable and false otherwise.

Also add tracer_tracing_is_on_cpu() to return if the ring buffer for a
given CPU is writeable for a given trace_array.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/ring_buffer.h |  1 +
 kernel/trace/ring_buffer.c  | 18 ++++++++++++++++++
 kernel/trace/trace.h        | 15 +++++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index 56e27263acf8..cd7f0ae26615 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -192,6 +192,7 @@ void ring_buffer_record_off(struct trace_buffer *buffer);
 void ring_buffer_record_on(struct trace_buffer *buffer);
 bool ring_buffer_record_is_on(struct trace_buffer *buffer);
 bool ring_buffer_record_is_set_on(struct trace_buffer *buffer);
+bool ring_buffer_record_is_on_cpu(struct trace_buffer *buffer, int cpu);
 void ring_buffer_record_disable_cpu(struct trace_buffer *buffer, int cpu);
 void ring_buffer_record_enable_cpu(struct trace_buffer *buffer, int cpu);
 
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index c0f877d39a24..1ca482955dae 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -4882,6 +4882,24 @@ bool ring_buffer_record_is_set_on(struct trace_buffer *buffer)
 	return !(atomic_read(&buffer->record_disabled) & RB_BUFFER_OFF);
 }
 
+/**
+ * ring_buffer_record_is_on_cpu - return true if the ring buffer can write
+ * @buffer: The ring buffer to see if write is enabled
+ * @cpu: The CPU to test if the ring buffer can write too
+ *
+ * Returns true if the ring buffer is in a state that it accepts writes
+ *   for a particular CPU.
+ */
+bool ring_buffer_record_is_on_cpu(struct trace_buffer *buffer, int cpu)
+{
+	struct ring_buffer_per_cpu *cpu_buffer;
+
+	cpu_buffer = buffer->buffers[cpu];
+
+	return ring_buffer_record_is_set_on(buffer) &&
+		!atomic_read(&cpu_buffer->record_disabled);
+}
+
 /**
  * ring_buffer_record_disable_cpu - stop all writes into the cpu_buffer
  * @buffer: The ring buffer to stop writes to.
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 79be1995db44..294d92179a02 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -671,6 +671,21 @@ struct dentry *trace_create_file(const char *name,
 				 void *data,
 				 const struct file_operations *fops);
 
+
+/**
+ * tracer_tracing_is_on_cpu - show real state of ring buffer enabled on for a cpu
+ * @tr : the trace array to know if ring buffer is enabled
+ * @cpu: The cpu buffer to check if enabled
+ *
+ * Shows real state of the per CPU buffer if it is enabled or not.
+ */
+static inline bool tracer_tracing_is_on_cpu(struct trace_array *tr, int cpu)
+{
+	if (tr->array_buffer.buffer)
+		return ring_buffer_record_is_on_cpu(tr->array_buffer.buffer, cpu);
+	return false;
+}
+
 int tracing_init_dentry(void);
 
 struct ring_buffer_event;
-- 
2.47.2


