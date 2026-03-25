Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978B91531E8;
	Wed, 25 Mar 2026 02:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774405528; cv=none; b=cdyJkWppVe1Nacdt+SYFsSqpmGiEZBw2p3FcLQHNAQYQaf+l1Rsgm3hdj36XcNLa7LYn+9T1zLPFXw97JiU9l91h8ICvzwSG2EsvfCosVHQOdkbdfkuLV4XQ1LA6gIOXgBRIrcSbo60GvCsNAvF8r8166d7lHRdtF1+7oPXMz4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774405528; c=relaxed/simple;
	bh=Fko1PvTEGwbkNmnatL73nX8waKA9pBeCk1aSg9U3Hk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jmyppd/Bf//u8t59Sl+N+BI8zP8NgKVhRlPWGBlWxsQ2HaNo8TMGwSkfaIlC19rH6m84lulSDcYR5Zic0p6b5NJYahZuxlijF8Y4i+OpDHayYVL/ISeLS7+g4wG8/H6T3mMYI1KyDx/sVauqo6o52C6bwkov5c7owlKwDIqsciA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hRp3eFBL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hRp3eFBL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B0BC19424;
	Wed, 25 Mar 2026 02:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774405528;
	bh=Fko1PvTEGwbkNmnatL73nX8waKA9pBeCk1aSg9U3Hk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hRp3eFBLW2kcGwvrckWG4UtEtmGNXgM4fnqL6tQZfQXmKOu/buk23tz3ic5FHuY6t
	 6J7ozvViBUDp/ZHWp1SUAa1xd77eMaQyNUJnmvaTe/xVGHXzZ+Ash854kmkxjtL8FU
	 TpHLCCA5sd+oU/RSmDPqxp5KJvTDDqerGVGQcjYPFJoX04yVubTyBrBXF4vo7AWxOu
	 WjXQDPLQlgq05jIUk2qPyDB55+YMWc48MDKkgI3oos25Pm//aSgoPQ4iSpR1UBVkIa
	 zqKMONxNUAWrjL1JdDDNPcdy965+7YGuixGawSlVdA14omPfepPYZfktr1QkB7L7Sq
	 OVGbYGbEqkMBg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Ian Rogers <irogers@google.com>
Subject: [PATCH v13 4/4] ring-buffer: Add persistent ring buffer selftest
Date: Wed, 25 Mar 2026 11:25:25 +0900
Message-ID:  <177440552560.1529621.1405976992959650354.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
In-Reply-To:  <177440549083.1529621.15486836623498328967.stgit@mhiramat.tok.corp.google.com>
References:  <177440549083.1529621.15486836623498328967.stgit@mhiramat.tok.corp.google.com>
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
index e130da35808f..094d5511bb17 100644
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
index e5178239f2f9..10443347a6d8 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -64,6 +64,10 @@ struct ring_buffer_cpu_meta {
 	unsigned long	commit_buffer;
 	__u32		subbuf_size;
 	__u32		nr_subbufs;
+#ifdef CONFIG_RING_BUFFER_PERSISTENT_SELFTEST
+	__u32		nr_invalid;
+	__u32		entry_bytes;
+#endif
 	int		buffers[];
 };
 
@@ -2077,6 +2081,19 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 
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
@@ -2557,12 +2574,64 @@ static void rb_free_cpu_buffer(struct ring_buffer_per_cpu *cpu_buffer)
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
index 4189ec9df6a5..108b0d16badf 100644
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

