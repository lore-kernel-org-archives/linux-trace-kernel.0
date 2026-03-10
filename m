Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8281C36EA95;
	Tue, 10 Mar 2026 10:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773137778; cv=none; b=FI+mZD0OT08reI+ddl9CnS6CfHtPumE1h6O6vd3Ewydo2jjficI2qh6peageJHtqTAvLcudyAAepwuxiDE5Rzov/8RfGRsYjXb2DJ/N+U7Z2QZ8STvPiR5WHSgoJpZUWYtaIh900dg2xPgr+YOaC6OcRPQw8g6G3DrVasByGDh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773137778; c=relaxed/simple;
	bh=8GZBMrsat3h1H9a0cg7EdpK78GmRpMpMtnhYDBDsUr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SVklwldDLzVMmB3qavMeRD+P41pld60QF8UwADmLkmXzLjO9EtKrA68fAtzz87p3htKTC+WAi03fYCZcU/Baf+c+YmsZrJPHVbbNy/7WLSO/aBr3VhUB17P9obDBsxqwK3sXPzt7RXf451oS3OKpf7onx6V3tvU7MnxITkI+ccg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hIvY9t6L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hIvY9t6L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B9CCC19423;
	Tue, 10 Mar 2026 10:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773137778;
	bh=8GZBMrsat3h1H9a0cg7EdpK78GmRpMpMtnhYDBDsUr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hIvY9t6LQWEPX5CkOjKJ4cGoVwcuBon1GXpEr1bAZpD80IgCs6TnCSPMHATymP8Fu
	 ZkIOa2jOMuDBMK6iU4cs8v+IHCd5LWMjSb6UHZ0Qo076xgU44uW9CCm1Rpy3Gg3oW6
	 6Wf08C1xYV6rw2h4hFmCUbH0EMwEGxNji9oJjcFWfWqdQUd3xGX8JOYDRo4WaU8HRg
	 ZzMlJZlpnrnE5tfQtmXQSlkRfX2cZr9UtgnOZeLafI1QqyyLXLr0vnolINQMEkrHWa
	 txt3lEA4jNqGBU0OuTqQcYW7PdSOibmf4/do7U9LU+RU1qugccnYdUtcwf39PeKciP
	 NCr+3nbIEFIbQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing: Add persistent ring buffer selftest
Date: Tue, 10 Mar 2026 19:16:13 +0900
Message-ID:  <177313777313.3322014.12042708486605360066.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
In-Reply-To:  <177303264034.767813.5345788067082238396.stgit@mhiramat.tok.corp.google.com>
References:  <177303264034.767813.5345788067082238396.stgit@mhiramat.tok.corp.google.com>
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
invalid pages is the same as record after reboot.

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

 Ring buffer meta [1] invalid buffer page detected
 Ring buffer meta [1] is from previous boot! (318 pages discarded)
 Ring buffer testing [1]: PASSED (318/318)

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 include/linux/ring_buffer.h |    1 +
 kernel/trace/Kconfig        |   15 +++++++++++++
 kernel/trace/ring_buffer.c  |   51 +++++++++++++++++++++++++++++++++++++++++++
 kernel/trace/trace.c        |    4 +++
 4 files changed, 71 insertions(+)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index 876358cfe1b1..927b6e8587cb 100644
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
index a86a036b4100..44268751a02c 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -63,6 +63,7 @@ struct ring_buffer_cpu_meta {
 	unsigned long	commit_buffer;
 	__u32		subbuf_size;
 	__u32		nr_subbufs;
+	__u32		nr_invalid;
 	int		buffers[];
 };
 
@@ -2086,6 +2087,11 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 
 	pr_info("Ring buffer meta [%d] is from previous boot! (%d pages discarded)\n",
 		cpu_buffer->cpu, discarded);
+	if (meta->nr_invalid)
+		pr_info("Ring buffer testing [%d]: %s (%d/%d)\n",
+			cpu_buffer->cpu,
+			(discarded == meta->nr_invalid) ? "PASSED" : "FAILED",
+			discarded, meta->nr_invalid);
 	return;
 
  invalid:
@@ -2488,12 +2494,57 @@ static void rb_free_cpu_buffer(struct ring_buffer_per_cpu *cpu_buffer)
 	kfree(cpu_buffer);
 }
 
+#ifdef CONFIG_RING_BUFFER_PERSISTENT_SELFTEST
+static void rb_test_inject_invalid_pages(struct trace_buffer *buffer)
+{
+	struct ring_buffer_per_cpu *cpu_buffer;
+	struct ring_buffer_cpu_meta *meta;
+	struct buffer_data_page *dpage;
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
+	/* Invalidate even pages. */
+	for (i = 0; i < meta->nr_subbufs; i += 2) {
+		int idx = meta->buffers[i];
+
+		dpage = (void *)(ptr + idx * subbuf_size);
+		/* Skip reader page and unused pages */
+		if (dpage == cpu_buffer->reader_page->page)
+			continue;
+		if (!local_read(&dpage->commit))
+			continue;
+		local_add(subbuf_size + 1, &dpage->commit);
+		invalid++;
+	}
+
+	pr_info("Inject invalidated %d pages on CPU%d\n", invalid, cpu);
+	meta->nr_invalid = invalid;
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
index 23de3719f495..eccc1ff22f71 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9336,6 +9336,8 @@ static void setup_trace_scratch(struct trace_array *tr,
 	memset(tscratch, 0, size);
 }
 
+#define TRACE_TEST_PTRACING_NAME	"ptracingtest"
+
 static int
 allocate_trace_buffer(struct trace_array *tr, struct array_buffer *buf, int size)
 {
@@ -9348,6 +9350,8 @@ allocate_trace_buffer(struct trace_array *tr, struct array_buffer *buf, int size
 	buf->tr = tr;
 
 	if (tr->range_addr_start && tr->range_addr_size) {
+		if (!strcmp(tr->name, TRACE_TEST_PTRACING_NAME))
+			rb_flags |= RB_FL_TESTING;
 		/* Add scratch buffer to handle 128 modules */
 		buf->buffer = ring_buffer_alloc_range(size, rb_flags, 0,
 						      tr->range_addr_start,

