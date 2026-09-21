Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4A148A2B5
	for <linux-trace-kernel@vger.kernel.org>; Mon, 21 Sep 2026 11:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789990262; cv=none; b=rxzoVlW7VS6EwoQavtKL5+PhDyLxgBPokCuoms30wxe7+7tUSgtfkCZ4bg7mQuheRQFH4U/DcFw+oF5wfoKJpnwA6kChyZXl+rpS18ZHPA79rJWKAE/zoQRpr8P6bXiszvkyG3uoCV3scbyPFcZWOea+AT9g3OyApLAJ2v5TRGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789990262; c=relaxed/simple;
	bh=9dltOTY5W3st8f6o8eojKeU7GISRoJFX8HrYBAuzy68=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VDvZaSwp+Aw5zWxMWY7x7q3D/jpJn5s3IbSlLwbECADMRo0mAXFxZuoqQWEKcAAtvUn2NpZdfJtAu7PJ2NvQt0RlRsM+LRrqn9cpJEycvr7h7myadUzyxuPOQ+pJA3iw0SYsC+lVACdST7ZTVACg1eg+0MTmb2GRq3Vms096jQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LHX4T3FV; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHX4T3FV"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccb65437so2141380a91.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 21 Sep 2026 04:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789990260; x=1790595060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GFqDrySe2EEhnLFCWQuL4eZJ1yzXDxQBkUH4V9YjE10=;
        b=LHX4T3FVfn/ZutJ4CChKG2tgnT51DjOVG2VXseQXRJuZla87eoShVgC4h8HJUSIbJQ
         QP7kI89qXL+osSj6idJLYAzj62ovlz3IrRQSWbAN0wViCsUlOD8fA/YMHG1ehyg+/T9j
         p2x0Z4pQnJq0bnvitbvufgHOXb1rAb30B0r3CYq6TFWLap64LOReTJIR5aNhCFnJK+q1
         xmGUtQrjRXxXyLMmISa9rAbi9yhTUC7/ejlaB+4+5GkSDE+6bghoxOSL7FiDcZ/Cqwj9
         ygQXekvJWXfLs/LxFbjHofXLFKGmQWOMKZF6rzmjf8S/zi5obMU8TiU2sX+teO2UIWYr
         A4dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789990260; x=1790595060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GFqDrySe2EEhnLFCWQuL4eZJ1yzXDxQBkUH4V9YjE10=;
        b=f6e9CqmUObMI4y1+iW13nnWLpHZEMDZknJpj6WwdrA1DBSGsy1I7Y+1CLASeOaYwxi
         OO/RYoJ0Mzf7XgbOe7BTbrz2zdNHRFgNIPFU5IHWtTMutS0wcfAlumjNJ4QQYf6C8BV0
         UQsBF74jk+FV7JsaE46Msl7ywwo/59qpSBRidIl/1+T7vxix6g0aMkOKJPEmTZ59IcPn
         gKXhFYb57PAF784zATMmwOcIEwT5u49CxuSNMlKMCm3sVQAdV/YrEzbqO8TXwBSYHy1w
         clIe3uB+ku3waCwK+5PAD23B9ibv0wUTOrZ9B6gLyfbFxjBvNfEgRVa0hUDL4mW7m+Sp
         1wwg==
X-Forwarded-Encrypted: i=1; AKwUvBx3hwqqyMWy6+RDk/9BPFFiDUU13miV4W2ALLaA9uNpW2/8kbRM6D8r8O8A190R9e0SrMcDQhIb/zqM2KrbPIH81Sw=@vger.kernel.org
X-Gm-Message-State: AFuF++kH2+gEk4QcCBUve9eW7mZmyRnApToIUkw1dAjlvWT1MzHmJcQk
	VjiTh4reWQivjXCyFjA5DL+Sf27CbJYAG+zEYUY5gH0ipMgdxMxhXtzu
X-Gm-Gg: AYBFou0G+YYgomvwODuQRSkrc55Q3qnHXu3DxjUe3SAsfiGyUJcchrLUls49NXrbmjE
	fTB71M0qGwTsO/AihsfqBcoGGH6gzRzabbeiPx5/vZq0pe0WPHjiqoz1g5iltawP1f0DYD/pdCr
	7d0jmHcPBpOu0YhsnUaOFACo2aVbNR246Y5F3e83SXAlh10rCd/lo3i6MSvDnPr1Ud46fqvlM1L
	wXyfF3X53vXM2p8Grf1rnLl8uz8JFBrtujcbCfN1Gzq8yEse77qiF3rd42qiw/5sCOKCEifCTEn
	anjq391gu0eTXEeAZKNKP38BCl3UGuGGvM7uagPkAqJYysbID1LkD76/+kgHKI9RQNDETQYnovI
	92N+HN5lkJYu98rBdS7JmpUHSSHhcW0KiRF1vhB8ELVNluc6FKINflUItS/zWWhZi+QPNYYgv/R
	glEFsubgTO1s+vogV4amz1E4p3qf1AvpT0lQlYO9MT+wEKBMyqdQRpo39EVGnz/llonz4tT0YM2
	OOL/grNzqXU4NcMJRHiPA2r5rfOUHsIfPWxoLI=
X-Received: by 2002:a17:90b:1e42:b0:3a0:345a:3620 with SMTP id 98e67ed59e1d1-3a0345a48a4mr5578898a91.45.1789990259880;
        Mon, 21 Sep 2026 04:30:59 -0700 (PDT)
Received: from bj-kjy-standalone-gaoxiang17.mioffice.cn ([43.224.245.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6ca86d83sm14003444a91.6.2026.09.21.04.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 04:30:59 -0700 (PDT)
From: Xiang Gao <gxxa03070307@gmail.com>
X-Google-Original-From: Xiang Gao <gaoxiang17@xiaomi.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Vincent Donnefort <vdonnefort@google.com>,
	Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	gao xu <gaoxu2@honor.com>,
	yinchuang1@xiaomi.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiang Gao <gaoxiang17@xiaomi.com>
Subject: [PATCH v4 1/2] tracing: add ring-buffer memory usage statistics in tracefs
Date: Mon, 21 Sep 2026 19:30:45 +0800
Message-Id: <20260921113047.1152602-2-gaoxiang17@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260921113047.1152602-1-gaoxiang17@xiaomi.com>
References: <20260916063322.472172-1-gaoxiang17@xiaomi.com>
 <20260921113047.1152602-1-gaoxiang17@xiaomi.com>
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

covering the global trace array, all instances, and the bootstrapping
temp_buffer across all CPUs.

The values account for the full pages backing the data sub-buffers and
reader page, plus the cached read page and mmap metadata page when
present. Slab-allocated ring-buffer metadata is not included, as it is
already reported through Slab and would be double-counted when
subtracting tracing memory from lost RAM. Remote buffers, whose pages
are externally owned, report zero.

Signed-off-by: Xiang Gao <gaoxiang17@xiaomi.com>
---
 Documentation/trace/ftrace.rst | 12 +++++
 include/linux/ring_buffer.h    |  1 +
 kernel/trace/ring_buffer.c     | 41 +++++++++++++++
 kernel/trace/trace.c           | 95 ++++++++++++++++++++++++++++++++++
 4 files changed, 149 insertions(+)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index 7261f25f8b4b..99ddfe26b7cd 100644
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
index eac3e9080c3c..96b99e6757d4 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -167,6 +167,7 @@ int ring_buffer_iter_empty(struct ring_buffer_iter *iter);
 bool ring_buffer_iter_dropped(struct ring_buffer_iter *iter);
 
 unsigned long ring_buffer_size(struct trace_buffer *buffer, int cpu);
+unsigned long ring_buffer_memory_size(struct trace_buffer *buffer, int cpu);
 unsigned long ring_buffer_max_event_size(struct trace_buffer *buffer);
 
 void ring_buffer_reset_cpu(struct trace_buffer *buffer, int cpu);
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 04bb94c29f58..efb88bf8970c 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6559,6 +6559,47 @@ unsigned long ring_buffer_size(struct trace_buffer *buffer, int cpu)
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
+ * Remote buffers do not own page-allocator memory and report zero.
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
+	/* Remote buffers use externally owned memory. */
+	if (buffer->remote)
+		return 0;
+
+	cpu_buffer = buffer->buffers[cpu];
+	subbuf_size = PAGE_SIZE << READ_ONCE(buffer->subbuf_order);
+
+	/* Data sub-buffers plus the reader page. */
+	size = (READ_ONCE(cpu_buffer->nr_pages) + 1) * subbuf_size;
+
+	/* The cached read page, if present, is a full sub-buffer page. */
+	if (READ_ONCE(cpu_buffer->free_page.data))
+		size += subbuf_size;
+
+	/* The mmap metadata page is a single system page. */
+	if (READ_ONCE(cpu_buffer->meta_page))
+		size += PAGE_SIZE;
+
+	return size;
+}
+
 /**
  * ring_buffer_max_event_size - return the max data size of an event
  * @buffer: The ring buffer.
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index e4a490d3d08c..d4a913ff8a69 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5771,6 +5771,79 @@ tracing_total_entries_read(struct file *filp, char __user *ubuf,
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
+	/*
+	 * temp_buffer is allocated in tracer_alloc_buffers() and is never
+	 * attached to a trace array. It temporarily holds event data for
+	 * triggers when tracing is off. Account for its pages too.
+	 */
+	if (temp_buffer) {
+		for_each_tracing_cpu(cpu)
+			stats.buffers += ring_buffer_memory_size(temp_buffer, cpu);
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
+
+static int trace_mem_open(struct inode *inode, struct file *file)
+{
+	int ret;
+
+	ret = tracing_check_open_get_tr(NULL);
+	if (ret)
+		return ret;
+
+	return single_open(file, trace_mem_show, inode->i_private);
+}
+
+static const struct file_operations trace_mem_fops = {
+	.open		= trace_mem_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 #define LAST_BOOT_HEADER ((void *)1)
 
 static void *l_next(struct seq_file *m, void *v, loff_t *pos)
@@ -9285,6 +9358,26 @@ static struct notifier_block trace_module_nb = {
 };
 #endif /* CONFIG_MODULES */
 
+static __init void init_trace_stats_tracefs(void)
+{
+	struct dentry *stats_dir;
+
+	/*
+	 * tracer_alloc_buffers() frees tracing_buffer_mask and temp_buffer
+	 * on failure without NULLing them, so do not iterate tracing CPUs
+	 * here when tracing failed to initialize.
+	 */
+	if (tracing_disabled)
+		return;
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
 
@@ -9293,6 +9386,8 @@ static __init void tracer_init_tracefs_work_func(struct work_struct *work)
 	init_tracer_tracefs(&global_trace, NULL);
 	ftrace_init_tracefs_toplevel(&global_trace, NULL);
 
+	init_trace_stats_tracefs();
+
 	trace_create_file("tracing_thresh", TRACE_MODE_WRITE, NULL,
 			&global_trace, &tracing_thresh_fops);
 
-- 
2.34.1

