Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272463A3E7B;
	Mon, 23 Mar 2026 12:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774269083; cv=none; b=iRJqTW1GUDH/MIZywIqR11Z/eJMWPPzvnEchNGJso1u48LJ3TMUAsLPYZ/M6sKSwEyZOVPF6K2+qP9OwldK4ry2G0cMppmeH9fW7EH5o5NVFF0HBJR4wrIKPWKQ8V0OXNEuT0v1GuX+YzP7Suiy/WNUkWkklSrFvzLtNp8hhU9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774269083; c=relaxed/simple;
	bh=bUKHhJZRGs+KlQpeQvn8rgQKHVihpV9ozTK8nHWkUqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ok++gLiTiLY+KPyNlr8WwFC6biS22CKRHj/H5Q8gcFfs4GsikK0eku9DbaUtSs4r1OJK7Ml9zQJM+oVQzA0FG+Hg8zjNb4A2gU+X6yLXECUuh2Maw8HHCYjtgs7efLDkBC+K2gx89oqwTl7E9FYwwHnqEx24Grvefe52+TbSgAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FzYrZtYH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FzYrZtYH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C2D7C4CEF7;
	Mon, 23 Mar 2026 12:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774269082;
	bh=bUKHhJZRGs+KlQpeQvn8rgQKHVihpV9ozTK8nHWkUqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FzYrZtYH125NGF31pJQb366lp9UOfBqbIt4e5+ZzB39ZcJeap4YHvbpDSjKgRhAKS
	 diQyYrjzWNhHKLkdws8WPj3WBRCrqSARhnVEfp1vCnGFaj6Zrluw1ZhIe4w5XM45lX
	 EhCMHr7LsreOFyLDj/Bth6MxUNNYAXekqwdmNZJ6UI9spD55GTmDm5yxcqymJz4NDl
	 H3xZkP1ODTK/Ri+TZkZhDSYvHFwBr5ZlexbojXovFuoth7kx3cfTGxYwmMytRDd9MX
	 OcxjJy13wAxggfUKhhb2Fr2OxdwNiWd4HvZJkg/hE8/Vn6YvKzA6osOowl76S6pqfz
	 PwVNNp4b/9AoQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Ian Rogers <irogers@google.com>
Subject: [PATCH v11 4/4] ring-buffer: Add persistent ring buffer selftest
Date: Mon, 23 Mar 2026 21:31:20 +0900
Message-ID:  <177426907988.3236905.6611992404780334487.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.53.0.983.g0bb29b3bc5-goog
In-Reply-To:  <177426904455.3236905.2079719303397330696.stgit@mhiramat.tok.corp.google.com>
References:  <177426904455.3236905.2079719303397330696.stgit@mhiramat.tok.corp.google.com>
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

Add a self-destractive test for the persistent ring buffer. This
will invalidate some sub-buffer pages in the persistent ring buffer
when kernel gets panic, and check whether the number of detected
invalid pages and the total entry_bytes are the same as record
after reboot.

This can ensure the kernel correctly recover partially corrupted
persistent ring buffer when boot.

The test only runs on the persistent ring buffer whose name is
"ptracingtest". And user has to fill it up with events before
kernel panics.

To run the test, enable CONFIG_RING_BUFFER_PERSISTENT_SELFTEST
and you have to setup the kernel cmdline;

 reserve_mem=20M:2M:trace trace_instance=ptracingtest^traceoff@trace
 panic=1

And run following commands after the 1st boot;

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
---
 Changes in v10:
  - Add entry_bytes test.
  - Do not compile test code if CONFIG_RING_BUFFER_PERSISTENT_SELFTEST=n.
 Changes in v9:
  - Test also reader pages.
---
 include/linux/ring_buffer.h |    1 +
 kernel/trace/Kconfig        |   15 +++++++++
 kernel/trace/ring_buffer.c  |   69 +++++++++++++++++++++++++++++++++++++++++++
 kernel/trace/trace.c        |    4 ++
 4 files changed, 89 insertions(+)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index d862fa610270..a92a22c44387 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -238,6 +238,7 @@ int ring_buffer_subbuf_size_get(struct trace_buffer *buffer);
 
 enum ring_buffer_flags {
 	RB_FL_OVERWRITE		= 1 << 0,
+	RB_FL_TESTING		= 1 << 1,
 };
 
 #ifdef CONFIG_RING_BUFFER
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 49de13cae428..2e6f3b7c6a31 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -1202,6 +1202,21 @@ config RING_BUFFER_VALIDATE_TIME_DELTAS
 	  Only say Y if you understand what this does, and you
 	  still want it enabled. Otherwise say N
 
+config RING_BUFFER_PERSISTENT_SELFTEST
+	bool "Enable persistent ring buffer selftest"
+	depends on RING_BUFFER
+	help
+	  Run a selftest on the persistent ring buffer which names
+	  "ptracingtest" (and its backup) when panic_on_reboot by
+	  invalidating ring buffer pages.
+	  Note that user has to enable events on the persistent ring
+	  buffer manually to fill up ring buffers before rebooting.
+	  Since this invalidates the data on test target ring buffer,
+	  "ptracingtest" persistent ring buffer must not be used for
+	  actual tracing, but only for testing.
+
+	  If unsure, say N
+
 config MMIOTRACE_TEST
 	tristate "Test module for mmiotrace"
 	depends on MMIOTRACE && m
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 99f59f1c63e0..31e479143ca0 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -63,6 +63,10 @@ struct ring_buffer_cpu_meta {
 	unsigned long	commit_buffer;
 	__u32		subbuf_size;
 	__u32		nr_subbufs;
+#ifdef CONFIG_RING_BUFFER_PERSISTENT_SELFTEST
+	__u32		nr_invalid;
+	__u32		entry_bytes;
+#endif
 	int		buffers[];
 };
 
@@ -2106,6 +2110,19 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 
 	pr_info("Ring buffer meta [%d] is from previous boot! (%d pages discarded)\n",
 		cpu_buffer->cpu, discarded);
+
+#ifdef CONFIG_RING_BUFFER_PERSISTENT_SELFTEST
+	if (meta->nr_invalid)
+		pr_info("Ring buffer testing [%d] invalid pages: %s (%d/%d)\n",
+			cpu_buffer->cpu,
+			(discarded == meta->nr_invalid) ? "PASSED" : "FAILED",
+			discarded, meta->nr_invalid);
+	if (meta->entry_bytes)
+		pr_info("Ring buffer testing [%d] entry_bytes: %s (%ld/%ld)\n",
+			cpu_buffer->cpu,
+			(entry_bytes == meta->entry_bytes) ? "PASSED" : "FAILED",
+			(long)entry_bytes, (long)meta->entry_bytes);
+#endif
 	return;
 
  invalid:
@@ -2508,12 +2525,64 @@ static void rb_free_cpu_buffer(struct ring_buffer_per_cpu *cpu_buffer)
 	kfree(cpu_buffer);
 }
 
+#ifdef CONFIG_RING_BUFFER_PERSISTENT_SELFTEST
+static void rb_test_inject_invalid_pages(struct trace_buffer *buffer)
+{
+	struct ring_buffer_per_cpu *cpu_buffer;
+	struct ring_buffer_cpu_meta *meta;
+	struct buffer_data_page *dpage;
+	u32 entry_bytes = 0;
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
+	meta = cpu_buffer->ring_meta;
+	ptr = (unsigned long)rb_subbufs_from_meta(meta);
+	subbuf_size = meta->subbuf_size;
+
+	for (i = 0; i < meta->nr_subbufs; i++) {
+		int idx = meta->buffers[i];
+
+		dpage = (void *)(ptr + idx * subbuf_size);
+		/* Skip unused pages */
+		if (!local_read(&dpage->commit))
+			continue;
+
+		/* Invalidate even pages. */
+		if (!(i & 0x1)) {
+			local_add(subbuf_size + 1, &dpage->commit);
+			invalid++;
+		} else {
+			/* Count total commit bytes. */
+			entry_bytes += local_read(&dpage->commit);
+		}
+	}
+
+	pr_info("Inject invalidated %d pages on CPU%d, total size: %ld\n",
+		invalid, cpu, (long)entry_bytes);
+	meta->nr_invalid = invalid;
+	meta->entry_bytes = entry_bytes;
+}
+#else /* !CONFIG_RING_BUFFER_PERSISTENT_SELFTEST */
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
index a626211ceb9a..561bcc1c9125 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9366,6 +9366,8 @@ static void setup_trace_scratch(struct trace_array *tr,
 	memset(tscratch, 0, size);
 }
 
+#define TRACE_TEST_PTRACING_NAME	"ptracingtest"
+
 static int
 allocate_trace_buffer(struct trace_array *tr, struct array_buffer *buf, unsigned long size)
 {
@@ -9378,6 +9380,8 @@ allocate_trace_buffer(struct trace_array *tr, struct array_buffer *buf, unsigned
 	buf->tr = tr;
 
 	if (tr->range_addr_start && tr->range_addr_size) {
+		if (!strcmp(tr->name, TRACE_TEST_PTRACING_NAME))
+			rb_flags |= RB_FL_TESTING;
 		/* Add scratch buffer to handle 128 modules */
 		buf->buffer = ring_buffer_alloc_range(size, rb_flags, 0,
 						      tr->range_addr_start,

