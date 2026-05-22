Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E571047B405;
	Fri, 22 May 2026 17:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779469830; cv=none; b=ety1dgOzC5lUOqBdxxWIgxfqPIHw5ptnLf7krdFVFj4Zas/oUNV+3DNDt/rhq9FeB3CoolpctXe7sestzGYs+RQUBghNLrbK6cxEsUQwBe+Sm9f86VlVyYiKUkI/fEsy4o+GdEEpmFFhvbKAB8G5MUjnpN2wMZnzDjlL/J/p14Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779469830; c=relaxed/simple;
	bh=nIFnGh0infRDGQFzQ6ebuiwUO7XdLygcHtj9yQZbODw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Rq2hXoPgl6RXXdDnfYK9eLCXYbuBfKoq/43hb0dSfq0WsXqVNZBmarGNYPNkP92URuehlkJZ3UTtNZhLxAgbgVpqzNYkb2oZzK+5L4kVTi0/qwERREexckQYE7nk/98pZMwPe++HPeha8QwuqeVdHAMvZBe9rQvscYPXg1VmIP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DSN6MfIY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DSN6MfIY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FECE1F00ADE;
	Fri, 22 May 2026 17:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779469827;
	bh=cZPlqlOdz3QHEQLAQDjctoR90c/McQe9fnMF3U+Crz8=;
	h=Date:From:To:Cc:Subject:References;
	b=DSN6MfIYXFbJctoUyy9O1mMELUOE/AsMSxtIw32iqM1KQLs25bdlaGw8bLOCWeCgf
	 +MevgaDjDjtdUnIG82hffGoZkxQ1L6RtdYi3ET1uotmM2y6lhdy1QiCOPHnOheNQBt
	 D/Ytt6HWYbiqSndcfeEPOPFMfS5hjprVSp7OIU59L2TEVWXYXejrLtwBkCbG74gF3F
	 ZzbBfrG8AEuJvNowk3HjUhyZX5F0Pd76XoYO6a22Y/rE2QX+Jv3qJg8XIGYSd68+Ma
	 FeryVcbr5/aTIRpqIiCUkzke30QRRR8TL7JhoDXoq1xZUwssx+Aum5f0y5fnGedIrf
	 uGb3UlFmYYg9A==
Received: from rostedt by gandalf with local (Exim 4.99.2)
	(envelope-from <rostedt@kernel.org>)
	id 1wQTOd-00000006BVQ-1hWw;
	Fri, 22 May 2026 13:10:51 -0400
Message-ID: <20260522171051.260140328@kernel.org>
User-Agent: quilt/0.69
Date: Fri, 22 May 2026 13:09:00 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Ian Rogers <irogers@google.com>
Subject: [PATCH v21 3/9] ring-buffer: Add persistent ring buffer invalid-page inject test
References: <20260522170857.263969486@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

Add a self-corrupting test for the persistent ring buffer.

This will inject an erroneous value to some sub-buffer pages (where
the index is even or multiples of 5) in the persistent ring buffer
when the kernel panics, and checks whether the number of detected
invalid pages and the total entry_bytes are the same as the recorded
values after reboot.

This ensures that the kernel can correctly recover a partially
corrupted persistent ring buffer after a reboot or panic.

The test only runs on the persistent ring buffer whose name is
"ptracingtest". The user has to fill it with events before a
kernel panic.

To run the test, enable CONFIG_RING_BUFFER_PERSISTENT_INJECT
and add the following kernel cmdline:

 reserve_mem=20M:2M:trace trace_instance=ptracingtest^traceoff@trace
 panic=1

Run the following commands after the 1st boot:

 cd /sys/kernel/tracing/instances/ptracingtest
 echo 1 > tracing_on
 echo 1 > events/enable
 sleep 3
 echo c > /proc/sysrq-trigger

After panic message, the kernel will reboot and run the verification
on the persistent ring buffer, e.g.

 Ring buffer meta [2] invalid buffer page detected
 Ring buffer meta [2] is from previous boot! (318 pages discarded)
 Ring buffer testing [2] invalid pages: PASSED (318/318)
 Ring buffer testing [2] entry_bytes: PASSED (1300476/1300476)

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 include/linux/ring_buffer.h |  1 +
 kernel/trace/Kconfig        | 34 ++++++++++++++++
 kernel/trace/ring_buffer.c  | 79 +++++++++++++++++++++++++++++++++++++
 kernel/trace/trace.c        |  4 ++
 4 files changed, 118 insertions(+)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index 994f52b34344..0670742b2d60 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -238,6 +238,7 @@ int ring_buffer_subbuf_size_get(struct trace_buffer *buffer);
 
 enum ring_buffer_flags {
 	RB_FL_OVERWRITE		= 1 << 0,
+	RB_FL_TESTING		= 1 << 1,
 };
 
 #ifdef CONFIG_RING_BUFFER
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index e130da35808f..084f34dc6c9f 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -1202,6 +1202,40 @@ config RING_BUFFER_VALIDATE_TIME_DELTAS
 	  Only say Y if you understand what this does, and you
 	  still want it enabled. Otherwise say N
 
+config RING_BUFFER_PERSISTENT_INJECT
+	bool "Enable persistent ring buffer error injection test"
+	depends on RING_BUFFER
+	help
+	  This option will have the kernel check if the persistent ring
+	  buffer is named "ptracingtest". and if so, it will corrupt some
+	  of its pages on a kernel panic. This is used to test if the
+	  persistent ring buffer can recover from some of its sub-buffers
+	  being corrupted.
+	  To use this, boot a kernel with a "ptracingtest" persistent
+	  ring buffer, e.g.
+
+	   reserve_mem=20M:2M:trace trace_instance=ptracingtest@trace panic=1
+
+	  And after the 1st boot, run the following commands:
+
+	   cd /sys/kernel/tracing/instances/ptracingtest
+	   echo 1 > events/enable
+	   echo 1 > tracing_on
+	   sleep 3
+	   echo c > /proc/sysrq-trigger
+
+	  After the panic message, the kernel will reboot and will show
+	  the test results in the console output.
+
+	  Note that events for the test ring buffer needs to be enabled
+	  prior to crashing the kernel so that the ring buffer has content
+	  that the test will corrupt.
+	  As the test will corrupt events in the "ptracingtest" persistent
+	  ring buffer, it should not be used for any other purpose other
+	  than this test.
+
+	  If unsure, say N
+
 config MMIOTRACE_TEST
 	tristate "Test module for mmiotrace"
 	depends on MMIOTRACE && m
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index c10cf4ba91d6..dc603d9c9414 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -64,6 +64,10 @@ struct ring_buffer_cpu_meta {
 	unsigned long	commit_buffer;
 	__u32		subbuf_size;
 	__u32		nr_subbufs;
+#ifdef CONFIG_RING_BUFFER_PERSISTENT_INJECT
+	__u32		nr_invalid;
+	__u32		entry_bytes;
+#endif
 	int		buffers[];
 };
 
@@ -2101,6 +2105,21 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 	if (discarded)
 		pr_cont(" (%d pages discarded)", discarded);
 	pr_cont("\n");
+
+#ifdef CONFIG_RING_BUFFER_PERSISTENT_INJECT
+	if (meta->nr_invalid)
+		pr_warn("Ring buffer testing [%d] invalid pages: %s (%d/%d)\n",
+			cpu_buffer->cpu,
+			(discarded == meta->nr_invalid) ? "PASSED" : "FAILED",
+			discarded, meta->nr_invalid);
+	if (meta->entry_bytes)
+		pr_warn("Ring buffer testing [%d] entry_bytes: %s (%ld/%ld)\n",
+			cpu_buffer->cpu,
+			(entry_bytes == meta->entry_bytes) ? "PASSED" : "FAILED",
+			(long)entry_bytes, (long)meta->entry_bytes);
+	meta->nr_invalid = 0;
+	meta->entry_bytes = 0;
+#endif
 	return;
 
  invalid:
@@ -2581,12 +2600,72 @@ static void rb_free_cpu_buffer(struct ring_buffer_per_cpu *cpu_buffer)
 	kfree(cpu_buffer);
 }
 
+#ifdef CONFIG_RING_BUFFER_PERSISTENT_INJECT
+static void rb_test_inject_invalid_pages(struct trace_buffer *buffer)
+{
+	struct ring_buffer_per_cpu *cpu_buffer;
+	struct ring_buffer_cpu_meta *meta;
+	struct buffer_data_page *dpage;
+	unsigned long entry_bytes = 0;
+	unsigned long ptr;
+	int subbuf_size;
+	int invalid = 0;
+	int cpu;
+	int i;
+
+	if (!(buffer->flags & RB_FL_TESTING))
+		return;
+
+	guard(preempt)();
+	cpu = smp_processor_id();
+
+	cpu_buffer = buffer->buffers[cpu];
+	if (!cpu_buffer)
+		return;
+	meta = cpu_buffer->ring_meta;
+	if (!meta)
+		return;
+
+	ptr = (unsigned long)rb_subbufs_from_meta(meta);
+	subbuf_size = meta->subbuf_size;
+
+	for (i = 0; i < meta->nr_subbufs; i++) {
+		unsigned long idx = meta->buffers[i];
+
+		dpage = (void *)(ptr + idx * subbuf_size);
+		/* Skip unused pages */
+		if (!local_read(&dpage->commit))
+			continue;
+
+		/*
+		 * Invalidate even pages or multiples of 5. This will cause 3
+		 * contiguous invalidated(empty) pages.
+		 */
+		if (!(i & 0x1) || !(i % 5)) {
+			local_add(subbuf_size + 1, &dpage->commit);
+			invalid++;
+		} else {
+			/* Count total commit bytes. */
+			entry_bytes += local_read(&dpage->commit) & ~RB_MISSED_MASK;
+		}
+	}
+
+	pr_info("Inject invalidated %d pages on CPU%d, total size: %ld\n",
+		invalid, cpu, (long)entry_bytes);
+	meta->nr_invalid = invalid;
+	meta->entry_bytes = entry_bytes;
+}
+#else /* !CONFIG_RING_BUFFER_PERSISTENT_INJECT */
+#define rb_test_inject_invalid_pages(buffer)	do { } while (0)
+#endif
+
 /* Stop recording on a persistent buffer and flush cache if needed. */
 static int rb_flush_buffer_cb(struct notifier_block *nb, unsigned long event, void *data)
 {
 	struct trace_buffer *buffer = container_of(nb, struct trace_buffer, flush_nb);
 
 	ring_buffer_record_off(buffer);
+	rb_test_inject_invalid_pages(buffer);
 	arch_ring_buffer_flush_range(buffer->range_addr_start, buffer->range_addr_end);
 	return NOTIFY_DONE;
 }
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 6eb4d3097a4d..4573f65d68ce 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8383,6 +8383,8 @@ static void setup_trace_scratch(struct trace_array *tr,
 	memset(tscratch, 0, size);
 }
 
+#define TRACE_TEST_PTRACING_NAME	"ptracingtest"
+
 int allocate_trace_buffer(struct trace_array *tr, struct array_buffer *buf, int size)
 {
 	enum ring_buffer_flags rb_flags;
@@ -8394,6 +8396,8 @@ int allocate_trace_buffer(struct trace_array *tr, struct array_buffer *buf, int
 	buf->tr = tr;
 
 	if (tr->range_addr_start && tr->range_addr_size) {
+		if (tr->name && !strcmp(tr->name, TRACE_TEST_PTRACING_NAME))
+			rb_flags |= RB_FL_TESTING;
 		/* Add scratch buffer to handle 128 modules */
 		buf->buffer = ring_buffer_alloc_range(size, rb_flags, 0,
 						      tr->range_addr_start,
-- 
2.53.0


