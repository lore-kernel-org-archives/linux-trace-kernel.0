Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209F7379988
	for <linux-trace-kernel@vger.kernel.org>; Sat,  5 Sep 2026 11:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788607668; cv=none; b=uvAkSKs2YgAZVV9r9k10ny+0723t6bqsCN5JElW14vYkGaMnb4i20hhaR7tuE5IN/VN4W6WROb2zxnCwyCsaduGTHreHXSzNgJojPKQhpcgGQHXTUHLlvSdgMkwW/V8q7x56O2TPZexbB/FhAJ15pUI1OjgNWA+nrxM3WCEbJrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788607668; c=relaxed/simple;
	bh=VNFHPPKGn+N+RMtH5qLML/9JFrA+89FDtV2J4klF95U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ow9HFyRec0iyQfMOcYcenURpdtLm+8TMexQAulF8g0oiesZ8XgWL4kth3fqKscg42lO3pheJ6dxLMAF6VU/tuPF9MLTp3dNB0bL9zoCvWph1TlM0Y4c8U6arxfExRyqptPZPWPZl+uoS5HtC8R+y63TWDqG1iHIEsQGVfIttK54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eWuOjKj7; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWuOjKj7"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-85590c5aeabso1294286b3a.3
        for <linux-trace-kernel@vger.kernel.org>; Sat, 05 Sep 2026 04:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788607666; x=1789212466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dyqTFR6AvFIuusPs/BBNN+wbp/Npj8yN3qdRzhCKNU4=;
        b=eWuOjKj76NMMq2eloPrLy7SyObTLqUtFNbQrmiE3OQ0cHFe7tPjnsAokAezMiAP6dN
         6mId7NwDPIfwmwvU2BCDuip5lj+lC1GHgn5jTVrhmPSPq+oT0MpZu08Z1z4kZZgrovUY
         yJ3n9/RF74ow2QIR1TH6ehLisb4zjACk1W6Zy7/82ycEGhjtHLiSjMfDrwXcBJ5WzWt2
         sAaaTPkTj3L69IoIMkuQtIzXJcAWCbb+B29xmw1zxQSDHL5915kXTXDC1YsFxE4ACKB4
         6QHH/xDFpYOj0ha8w5FS5mhvCpoSg1MXd9xE2QaegfPgwVS8eDTgfXj2A4Ef1an78LY5
         or+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788607666; x=1789212466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dyqTFR6AvFIuusPs/BBNN+wbp/Npj8yN3qdRzhCKNU4=;
        b=aJeUdJCAZ52tInmIcX5BIW2pP5t64lk9VsXV3JzJgNRVrBeMppoUksiSZr29oWBIm7
         jTh3UXh/uUnHej1OCStihU6JfFeAlviec2KsdbQQNyoZsQV4S1XyW5mHek8Y2YQ+eFBc
         EbmTcuv0muBWC4lTsVtf1XL/Xh3aIYSANiwnfOrR4E6ZJoEZ+LAvefNfjQ72PJJXTwFR
         HMBAG26z9AW9e6zVl7nM6ecMNJQ29ff8Yz5d3Zv7VuFQiNrre3bxBh1Ig0saqZaklpsx
         fSKWgFzjsYnFVMQ/WWomUlvwEXsn5sGAIGdWAppLIXepXHl4jm+qCYF+vpBRxnPRbBoa
         8irw==
X-Forwarded-Encrypted: i=1; AKwUvBxGibZeZHOFuT+iqa7mpLIxqjKImOnUN4Y4QbBNljeYhJTyhlltusleidK6J5yJaAdyoXitqYYlDVslLCVirODrics=@vger.kernel.org
X-Gm-Message-State: AFuF++k0hFhhjP68ylvxXM+4B5Rw9pvsVFkkyBRlzpvd0PVI9nc71ojR
	RFe/XqWBnozzpr3aPxbrgZmcpru37a0LnCYyTarRTC7jkKQoRWsNQCnV
X-Gm-Gg: AYBFou0pXdLG7cozhBauqkemXNSiC7cgooNisfQHWfu2ALrYYqrSDr40p59OuYgV32F
	B1dLPnNPlBWXUj8qnKqwMvZ2H9Nz2X6+LJFDhpUnq7IU+ApVTYq6tAHY8G60h0GgGDXOtGbYTJg
	ykcHVQ1lHfFX2YxqgX+CrlCVd2f2T/ecHIrHFFWQyVewNO5V7OuezYQf+qv0jckvhHyGYdmAr6G
	8C+/awTJ4jIQwEMwzC+c4zHqxJKqi9T79Ez6Z+LKt/Pbb3TCKw5OXwbLvmUC5v0eEKWCnH6GB2r
	Eoi+Cd/BAujlNxMaqlEj+NvukVx2U4QY2SQkYB9r669kVpBNmKnf3zBGnQemnt+0Peae9Mrq8DU
	P6QEyv/92VtwA4avJDxGEDP1OyaIssZjMsHpB/cMf5gafd9TqqwUkXI83HAo3xepJKZojHmmVxj
	5rZ2yqo/acyjs2VSTx8SBlQgMa3ohnctd2x+uzhoPZjQ1F7sL0xBuE+u/PpDhHHl47ClOxQ1lu7
	IXPySk5ic9ByG+nevNyTnlyLOCU
X-Received: by 2002:a05:6a00:4388:b0:857:7317:cff2 with SMTP id d2e1a72fcca58-8616a266f1bmr17075099b3a.19.1788607666212;
        Sat, 05 Sep 2026 04:27:46 -0700 (PDT)
Received: from bj-kjy-standalone-gaoxiang17.mioffice.cn ([43.224.245.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86152e39a38sm2228779b3a.39.2026.09.05.04.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 04:27:45 -0700 (PDT)
From: Xiang Gao <gxxa03070307@gmail.com>
X-Google-Original-From: Xiang Gao <gaoxiang17@xiaomi.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	gao xu <gaoxu2@honor.com>,
	yinchuang1@xiaomi.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiang Gao <gaoxiang17@xiaomi.com>
Subject: [PATCH 1/2] tracing: add ring-buffer memory usage statistics in tracefs
Date: Sat,  5 Sep 2026 19:27:31 +0800
Message-Id: <20260905112732.3705405-2-gaoxiang17@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260905112732.3705405-1-gaoxiang17@xiaomi.com>
References: <20260905112732.3705405-1-gaoxiang17@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Report the memory consumed by the tracing ring buffers, rather than the
usable data capacity exposed by buffer_size_kb. Android low-memory
diagnostics need this to attribute the memory used by tracing when
calculating lost RAM.

The buffers can be spread across the global trace array, dynamically
created instances, and snapshot buffers. Userspace currently has to
discover and sum every instance, and snapshot memory is not exposed by
the per-instance totals.

Add a trace_stats directory with memory_usage_kb reporting:

  buffers:
  snapshot_buffers:

covering the global trace array and all instances across all CPUs.

The values account for the full pages backing the data sub-buffers and
reader page, plus the cached read page and mmap metadata page when
present. Slab-allocated ring-buffer metadata is not included, as it is
already reported through Slab and would be double-counted when
subtracting tracing memory from lost RAM. Range and remote buffers,
whose pages are externally owned, report zero.

Signed-off-by: Xiang Gao <gaoxiang17@xiaomi.com>
---
 Documentation/trace/ftrace.rst | 12 +++++++
 include/linux/ring_buffer.h    |  1 +
 kernel/trace/ring_buffer.c     | 41 +++++++++++++++++++++++
 kernel/trace/trace.c           | 60 ++++++++++++++++++++++++++++++++++
 4 files changed, 114 insertions(+)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index 84f06bf0da9b..ff9d604dd1b8 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -218,6 +218,18 @@ of ftrace. Here is a list of some of the key files:
 
 	This displays the total combined size of all the trace buffers.
 
+  trace_stats/memory_usage_kb:
+
+	This reports the memory consumed by the ring buffers, as opposed to
+	the usable data capacity shown by buffer_size_kb. The value covers the
+	main and snapshot buffers of the global trace array and all tracing
+	instances. It does not include slab-allocated ring-buffer metadata.
+
+	Output::
+
+	    buffers: ...
+	    snapshot_buffers: ...
+
   buffer_subbuf_size_kb:
 
 	This sets or displays the sub buffer size. The ring buffer is broken up
diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index 0670742b2d60..64eded40222c 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -166,6 +166,7 @@ int ring_buffer_iter_empty(struct ring_buffer_iter *iter);
 bool ring_buffer_iter_dropped(struct ring_buffer_iter *iter);
 
 unsigned long ring_buffer_size(struct trace_buffer *buffer, int cpu);
+unsigned long ring_buffer_memory_size(struct trace_buffer *buffer, int cpu);
 unsigned long ring_buffer_max_event_size(struct trace_buffer *buffer);
 
 void ring_buffer_reset_cpu(struct trace_buffer *buffer, int cpu);
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 8e2485bb3aa8..a8719b517798 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6464,6 +6464,47 @@ unsigned long ring_buffer_size(struct trace_buffer *buffer, int cpu)
 }
 EXPORT_SYMBOL_GPL(ring_buffer_size);
 
+/**
+ * ring_buffer_memory_size - return the memory used by the buffer (in bytes)
+ * @buffer: The ring buffer.
+ * @cpu: The CPU to get ring buffer memory from.
+ *
+ * Returns the page-allocator memory consumed by @cpu, including the data
+ * sub-buffers, the reader page, the cached read page, and the mmap
+ * metadata page. Unlike ring_buffer_size(), which reports the usable data
+ * capacity, this accounts for the full pages allocated to the buffer.
+ * Range and remote buffers do not own page-allocator memory and report zero.
+ */
+unsigned long ring_buffer_memory_size(struct trace_buffer *buffer, int cpu)
+{
+	struct ring_buffer_per_cpu *cpu_buffer;
+	unsigned long subbuf_size;
+	unsigned long size;
+
+	if (!cpumask_test_cpu(cpu, buffer->cpumask))
+		return 0;
+
+	/* Range and remote buffers use externally owned memory. */
+	if (buffer->range_addr_start || buffer->remote)
+		return 0;
+
+	cpu_buffer = buffer->buffers[cpu];
+	subbuf_size = PAGE_SIZE << buffer->subbuf_order;
+
+	/* Data sub-buffers plus the reader page. */
+	size = (cpu_buffer->nr_pages + 1) * subbuf_size;
+
+	/* The cached read page, if present, is a full sub-buffer page. */
+	if (cpu_buffer->free_page)
+		size += subbuf_size;
+
+	/* The mmap metadata page is a single system page. */
+	if (cpu_buffer->meta_page)
+		size += PAGE_SIZE;
+
+	return size;
+}
+
 /**
  * ring_buffer_max_event_size - return the max data size of an event
  * @buffer: The ring buffer.
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 01a5e87af299..b343e03a6cf8 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5769,6 +5769,52 @@ tracing_total_entries_read(struct file *filp, char __user *ubuf,
 	return simple_read_from_buffer(ubuf, cnt, ppos, buf, r);
 }
 
+struct trace_mem_stats {
+	unsigned long	buffers;
+	unsigned long	snapshot;
+};
+
+static void
+trace_array_buffer_memory(struct trace_array *tr, int cpu,
+			  unsigned long *buffers, unsigned long *snapshot)
+{
+	if (tr->array_buffer.buffer)
+		*buffers += ring_buffer_memory_size(tr->array_buffer.buffer, cpu);
+
+#ifdef CONFIG_TRACER_SNAPSHOT
+	if (tr->snapshot_buffer.buffer)
+		*snapshot += ring_buffer_memory_size(tr->snapshot_buffer.buffer, cpu);
+#endif
+}
+
+static struct trace_mem_stats trace_buffers_memory(void)
+{
+	struct trace_mem_stats stats = {};
+	struct trace_array *tr;
+	int cpu;
+
+	guard(mutex)(&trace_types_lock);
+
+	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
+		for_each_tracing_cpu(cpu)
+			trace_array_buffer_memory(tr, cpu, &stats.buffers,
+						  &stats.snapshot);
+	}
+
+	return stats;
+}
+
+static int trace_mem_show(struct seq_file *m, void *v)
+{
+	struct trace_mem_stats stats = trace_buffers_memory();
+
+	seq_printf(m, "buffers: %lu\n", stats.buffers >> 10);
+	seq_printf(m, "snapshot_buffers: %lu\n", stats.snapshot >> 10);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(trace_mem);
+
 #define LAST_BOOT_HEADER ((void *)1)
 
 static void *l_next(struct seq_file *m, void *v, loff_t *pos)
@@ -9188,6 +9234,18 @@ static struct notifier_block trace_module_nb = {
 };
 #endif /* CONFIG_MODULES */
 
+static __init void init_trace_stats_tracefs(void)
+{
+	struct dentry *stats_dir;
+
+	stats_dir = tracefs_create_dir("trace_stats", NULL);
+	if (!stats_dir)
+		return;
+
+	trace_create_file("memory_usage_kb", TRACE_MODE_READ, stats_dir,
+			  NULL, &trace_mem_fops);
+}
+
 static __init void tracer_init_tracefs_work_func(struct work_struct *work)
 {
 
@@ -9196,6 +9254,8 @@ static __init void tracer_init_tracefs_work_func(struct work_struct *work)
 	init_tracer_tracefs(&global_trace, NULL);
 	ftrace_init_tracefs_toplevel(&global_trace, NULL);
 
+	init_trace_stats_tracefs();
+
 	trace_create_file("tracing_thresh", TRACE_MODE_WRITE, NULL,
 			&global_trace, &tracing_thresh_fops);
 
-- 
2.34.1

