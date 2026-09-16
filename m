Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6433B71B7
	for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Sep 2026 06:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789540415; cv=none; b=aLliHq5RVCSPAnbHeG1sG8knV6WbtEU4Efm6Oxt3ru2wHFBjT6inihOmCEePkTBx2WTZtTBr31lfHgxvL9s9y6QJGbbqcvC5CQQtNgbzRhvYrd8GuirB4P+VoDa2frYWLQjVnXbGkuEl7qoqegwoUMJiMdWZ/DlYcDvWxyaCvT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789540415; c=relaxed/simple;
	bh=lijykbdW3DUSEuIClarYprF6N8frF+4MGSdTU5pVmQI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iWizjkQnNKF4VL+IAGW/NN0qIZHh45Atx7NPSn/aPkFr828Gv+xn9Mk3x54sLVeZaBbsWAbKHJ8FaOr2vgIIvdqAz3BIceRyEt1MlBM5bvprKwkcwJMNkwozH5nVQ7qdYYB/w5/MWMyEnr4lJz2IkEyFJgUb+IaZR9uJsmPf0W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nr9WHich; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nr9WHich"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc4cdc0d663so315423a12.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 15 Sep 2026 23:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789540414; x=1790145214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8uYyB2YfPu92WC7DEpcCVyFiTycvVz1Sx2/pRb+T3vQ=;
        b=nr9WHichKWTwte9yyhs2/4mcMkzMfWXH6f7MbzCPVZVL7EgMHZUYBL+qamNwqGFhp0
         SK3Q0s1IJ/fhkYrKrym1OHPyFWbnJKM0DK8TDDR5/ZJ7uhbPa3popHUg0/gJ4WJ7/1Pa
         ZoeMKpNxqdi7skQmGaTPprTGkqsd7d1xZZYwg6+6mTjPD/ZXzrmcINj8IhJohALxvSZl
         SxHcT+nBuhDtzSNI2S05+PTrttHMiwnMHLEh2mgx7W96Ky9/QRDCAEoLQrBqxtg1rsnS
         JAGnV/T1saOM1XTsWVL0994kg1aIync+SlcybeUBIv7r+iL7BjQJIdjbA7g/e3oFiYL0
         eZdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789540414; x=1790145214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8uYyB2YfPu92WC7DEpcCVyFiTycvVz1Sx2/pRb+T3vQ=;
        b=BcaSgpH1e7IahM8kaeWWUO7h4tQj9Wa0eOpXoDfLtMQbHN03eJQpHzInysLID489KF
         z4f+WOrIi+ExXS5vrzWy582YoXvxDEQlyUEKweJKSpR7ojfL1hAOZyh7wlwOe78NErUN
         cUigf2cXNh8xlsLfBVQUE9QInDKlDRDUid7ewRqsGmx/CRBre4066/bt175cwXMupgLB
         fVQvqHwkZ4DzPWDHs8A8QewOAfmY1Wj0/WaUrAYaNYB+FkDMsLwHbr/2tWHTAUKHhTWN
         PobsMbpiW0nCIuZG0VjNIXOZQK41MCzWddrwe29NlKnJr3HwGraLUtJ1BUr4t84Xnv0b
         vXNw==
X-Forwarded-Encrypted: i=1; AKwUvBwpwRiPHNKucExh9vc2uY9UVsht1y/W2cZFNoKsxFJdh7vop/E/lKG9O0Uy6b48csnhKKRNqsAPyfUo92ZFmOV1WxE=@vger.kernel.org
X-Gm-Message-State: AFuF++m5j4CaxG78HCPUCtdVdvCB9n8R2pzHMLNy2yjXeWRtrzpljEYx
	ux4G2VmJD3XX1wkiERwi1M/eSaXjeyZmvrGSCYVTuRiZSrs9VkkVFBqh
X-Gm-Gg: AYBFou29M1CR82q5KrGdzwV+6WVmjPO75YnUin7bcKo3/slrub0nALUtALg5LpQxRuy
	i7ry5N9v9S7vflCNFwt+wQa9k4UUVal38ROpIf4JYdBbid+vbq0c2kaLf6ZHWNUiyWE7/zQQ6Uj
	7/6GDAaNBiCzu+a1L2mZ7UJqxnHaiChEUk9f+0emZRCt3qi/nPyyHhsOJbJj9ngZeQ3bxbNfqds
	wSP1z+WUx3SlacQvkFeLKvtCksdyfUdUFesHHxNC9fcfdTtreskILHyKzhMBZcFu9a17FadtITC
	qvIcQEQprfj1ZiV4FlVlKPmbBK51gyfvnDS0L/AUh49qubTnN/B9G2HyjJmM0b4xtmuPXafWVcI
	l4tzW+Rk+zquqz1VTo9CO6CPCU3g1eu2Q1ajwtrE517yH+e+e5Wo+Y7xGvkJHFpM+aPs8UB/dQM
	xZydWcFbxcHY8hyC81vpmg07nSqU44pQ31l6R8Qd3IAbAUDChcBaND65dYqKRT0B3QlbUs4dHy0
	GOB+mwbySTSrDuIP5R77D5XjZNKsPxUXEAJ91Q=
X-Received: by 2002:a05:6a20:6a0c:b0:3b4:5ff3:45cb with SMTP id adf61e73a8af0-3dd5f45a0fcmr3697808637.8.1789540413667;
        Tue, 15 Sep 2026 23:33:33 -0700 (PDT)
Received: from bj-kjy-standalone-gaoxiang17.mioffice.cn ([43.224.245.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc50aba87basm1005550a12.23.2026.09.15.23.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 23:33:33 -0700 (PDT)
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
Subject: [PATCH v3 1/2] tracing: add ring-buffer memory usage statistics in tracefs
Date: Wed, 16 Sep 2026 14:33:21 +0800
Message-Id: <20260916063322.472172-2-gaoxiang17@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260916063322.472172-1-gaoxiang17@xiaomi.com>
References: <20260911155017.3377254-1-gaoxiang17@xiaomi.com>
 <20260916063322.472172-1-gaoxiang17@xiaomi.com>
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
 Documentation/trace/ftrace.rst | 12 ++++++
 include/linux/ring_buffer.h    |  1 +
 kernel/trace/ring_buffer.c     | 41 ++++++++++++++++++++
 kernel/trace/trace.c           | 70 ++++++++++++++++++++++++++++++++++
 4 files changed, 124 insertions(+)

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
index 04bb94c29f58..28002d343f09 100644
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
+	size = (cpu_buffer->nr_pages + 1) * subbuf_size;
+
+	/* The cached read page, if present, is a full sub-buffer page. */
+	if (cpu_buffer->free_page.data)
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
index e4a490d3d08c..796e239fbaf9 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5771,6 +5771,62 @@ tracing_total_entries_read(struct file *filp, char __user *ubuf,
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
+DEFINE_SHOW_ATTRIBUTE(trace_mem);
+
 #define LAST_BOOT_HEADER ((void *)1)
 
 static void *l_next(struct seq_file *m, void *v, loff_t *pos)
@@ -9285,6 +9341,18 @@ static struct notifier_block trace_module_nb = {
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
 
@@ -9293,6 +9361,8 @@ static __init void tracer_init_tracefs_work_func(struct work_struct *work)
 	init_tracer_tracefs(&global_trace, NULL);
 	ftrace_init_tracefs_toplevel(&global_trace, NULL);
 
+	init_trace_stats_tracefs();
+
 	trace_create_file("tracing_thresh", TRACE_MODE_WRITE, NULL,
 			&global_trace, &tracing_thresh_fops);
 
-- 
2.34.1

