Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793887379;
	b=EVJBw9yDzdx5k3RfXwTc6cff09pR7j/FH/xNw4FvhlzHY/ezn/DZ9+439yBm70TcWI19
	 nKruvA4pJncD7gHcYL8AloDN027jJfTGeTfY/+xsayB6Ui8I+SjJkOcJGKgI/Ywd6HHsZ
	 Q6gFfS4X8udKvhgvTdmTAI/mhZ6E/L8HZ5FVbnMqHj4rZmUkGsj3k4UVvXhReufNLieCW
	 NzqzRC5DI4X8x00F0G4kue5rtd2j5KOQY9Qr8J8vjbiQP6vJZItaDyenlA9huIEnO9srs
	 wLsbYS7swpp2lYCd454qZtsZ7Q/v3aiZES1rit8mjUQGgcwR1lXiZci/87oITlMUDfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793887379;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=zWzdUkniK2DubaKSt9KrrXa9DMcVat1kchWBMsUic1M=;
	b=fAAyjFS9Ej4hCecHceqAS1+9y2ngDGn+Xq26iqj2xfj0nY4Kih8IymVrna19FDhLwqJN
	 rAxyrkee05n6AZ/nlJrzOFO7c2hbDOS36h3QFowb8bNKJl9lFoFH6qMkHkPrQTRMeGcTT
	 Crm5MZyKaBRezLrrHYkBUvJysUdxulFzAunQg9nbuvBd9WPGUL9HZCU12rb8KzJVdCoQq
	 xHB2ZFkDlebfr8rkS0OhQiBQQxZYzRHkXCZ4usx4xGjMsa5bD3cWNm+iTORSXUJ+FN7Cz
	 AubWxDruwX3wQg7gnUGRmWeFX4oZZoEhSrKoo5rtshfgUQirxA4m97RgdPejt2CSkZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H5YxSlFJ;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F21606A339
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Nov 2026 14:02:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20F21606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H5YxSlFJ
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-14fc585291cso1884063c88.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 05 Nov 2026 06:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793887378; x=1794492178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zWzdUkniK2DubaKSt9KrrXa9DMcVat1kchWBMsUic1M=;
        b=H5YxSlFJNdaOdzfHiMdkN5TABx+o3DT8+eJOGATLpz78twsSJBtb9smSPQc9CXySQH
         bDIq+8oqHdtYhkZrmBC/7muPctZEud7dUB6/m8iRL9G60TCfUjTFrTefOwYumL2mlXAc
         ygsS+jn37vO7PeTnzKjsVjs6NL/31aUEsh1piWdNW21X88A5AJsLbe+OSzZKwbb5Efsk
         qCafV+FFL+HHhPu1/xTs7fRhpUKZvnS3ECPhQIviOQyFHVrh4JgqQ4p0AMOCZ5fpwmBn
         YoMmW7rjOgSzGT/yIyEU/5BV7yj4y07Y+TlBA4V72ZAxkidx5HOWvg0MOR9jjK6WhE7s
         npQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793887378; x=1794492178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zWzdUkniK2DubaKSt9KrrXa9DMcVat1kchWBMsUic1M=;
        b=HbTrJ36ZSkTXz5jA6BgfQmNZkPpXR2JsXvzMRn390MoI/A646MgDP3rIpiD6aoP8y9
         vXiN+VbJXdkdT1/k0uskxvXsd1qd4QY6XA268fpAocPELz2X4SJWanG0ISfFvT0R+K/J
         RvKGUps/mN/7hKWnRTY3z3Mv3Ok2dtbFQZSohpEYY8i2pMq0x6k9k34era6o/XJcAyg1
         3nunEgnHO/f0HfzVonhg+ovbUuKswup1lMTWJQEGsPoH9XZvJP3yIcj0SFz5KZ9d3QZx
         ntFo1Y5y+oYKyuYCcounYI89yI9lhaDmoGgGA1+lW2BlgAmAPexBCRfdBl0vqj5y6y4S
         qx8Q==
X-Forwarded-Encrypted: i=1; AKwUvByAx04GvrNfGVSQJASQvwhwq99yoKjWUGlXOY/aX+3D0qTV0K795XX/j142992ZJZzmG36Lu+W+r9rUoomX/kBGpvA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/DyTH+aQrQTFsf7jLDSbVsa5JJmr6SrXFpdQyVzG80s5AGGl0D
	XRplCCDKCVC+e1Dc6CGCjbngqo4jSejBi3EKklcSOVyFFal05u+ftNjC
X-Gm-Gg: AYBFou2A3CVo2Zw3wiezD0HohU2g8YQ1tBINoFUdPkkrqKrQ5gSon3jnyZwoFzcRKeT
	cja4la7ZBuyo3XXeCiOdYva+R9CDYGzuml5DUcQneYucuhrxYVC35f1pbNoZSxkkcuzo5lfRlca
	/0qTtxz6zLNeQTODSScRzKVp6zN/gU+xlIpHSfB7QWIBdL0qMF63pyOSeS39/JfUB2hwwCUZoqB
	zsUjl2v5k6goBp5cARGmuxjNzKVddNdhrs8JBfDIFQkQiNtnWCCexZkYpKJmfXpnM877RWN1/Zz
	HA6EC2e8nlLECj9GQfmlH8tmJ6qps5lo2iQQSpUXVeTVyKOe+P3IVIjSwfERJeTTr734/m82nzr
	mllsI/6/ksFdApK0TUlo5FF9vwZ7ZoaLfbLaCHer3IZYx51WBS6Dvi5cVStLcF/Unhy9Q4zmLw1
	sVjWww3TQ+rFmgNppNn0JblXXFXrph3WUp7RtUXvF1wKfrStzQp7dCX7rNprh/P1hbvVPRNWv+Y
	nkRAKNOKLrrN+V/arxnz5JiuuEIDSU2O1+TNDdMDr4ccvdcwXZhlmOpqZCjiNvcyVmg/dNWOEvk
	NgIBpkMoMBzlw9AMZgVbbZjXTm35gd9CvhgTgdrAJJ3eYQs7zz4YqNjn8ApTaNzoa9Z1bA==
X-Received: by 2002:a05:7022:1104:b0:19d:6484:869f with SMTP id a92af1059eb24-1ac5c369c59mr24480342c88.7.1793887377455;
        Thu, 05 Nov 2026 06:02:57 -0800 (PST)
Received: from bj-kjy-standalone-gaoxiang17.mioffice.cn ([43.224.245.230])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca3981ff0sm20969616eec.24.2026.11.05.06.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 06:02:57 -0800 (PST)
From: Xiang Gao <gxxa03070307@gmail.com>
X-Google-Original-From: Xiang Gao <gaoxiang17@xiaomi.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Vincent Donnefort <vdonnefort@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	gao xu <gaoxu2@honor.com>,
	yinchuang1@xiaomi.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiang Gao <gaoxiang17@xiaomi.com>
Subject: [PATCH v5 2/4] tracing: add aggregate buffer memory usage statistics
Date: Thu,  5 Nov 2026 22:02:19 +0800
Message-Id: <20261105140221.44614-3-gaoxiang17@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105140221.44614-1-gaoxiang17@xiaomi.com>
References: <20261105140221.44614-1-gaoxiang17@xiaomi.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a trace_stats directory with memory_usage_kb reporting the page
memory consumed by the tracing ring buffers, categorized by buffer type
and memory source:

  global:
  instances:
  snapshots:
  persistents:
  remotes:
  total_system:
  total_carveout:

The global, instances, and snapshots values come from the page
allocator. Persistent buffers use reserved memory and are reported under
persistents, while the backup instance uses vmalloc and is skipped since
it is already accounted in VmallocUsed. Remote buffers are not yet
enumerated and report zero.

total_system is the page-allocator memory that contributes to lost RAM,
while total_carveout is reserved memory that was never in the free pool.

Signed-off-by: Xiang Gao <gaoxiang17@xiaomi.com>
---
 kernel/trace/trace.c | 115 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index e8c4efa8107b..6036e368fe10 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5797,6 +5797,107 @@ tracing_total_capacity_read(struct file *filp, char __user *ubuf, size_t cnt, lo
 	return simple_read_from_buffer(ubuf, cnt, ppos, buf, r);
 }
 
+struct trace_mem_stats {
+	unsigned long	global;
+	unsigned long	instances;
+	unsigned long	snapshots;
+	unsigned long	persistents;
+	unsigned long	remotes;
+	unsigned long	total_system;
+	unsigned long	total_carveout;
+};
+
+static void
+trace_array_buffer_memory(struct trace_array *tr, int cpu,
+			  struct trace_mem_stats *stats)
+{
+	if (tr->range_addr_start) {
+		/*
+		 * Persistent buffers use reserved memory (carveout). The
+		 * backup instance uses vmalloc and is already accounted in
+		 * VmallocUsed, so skip it.
+		 */
+		if (!(tr->flags & TRACE_ARRAY_FL_VMALLOC))
+			stats->persistents +=
+				ring_buffer_memory_size(tr->array_buffer.buffer, cpu);
+	} else if (tr->flags & TRACE_ARRAY_FL_GLOBAL) {
+		stats->global +=
+			ring_buffer_memory_size(tr->array_buffer.buffer, cpu);
+	} else {
+		stats->instances +=
+			ring_buffer_memory_size(tr->array_buffer.buffer, cpu);
+	}
+
+#ifdef CONFIG_TRACER_SNAPSHOT
+	if (tr->snapshot_buffer.buffer)
+		stats->snapshots +=
+			ring_buffer_memory_size(tr->snapshot_buffer.buffer, cpu);
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
+			trace_array_buffer_memory(tr, cpu, &stats);
+	}
+
+	/*
+	 * temp_buffer is allocated in tracer_alloc_buffers() and is never
+	 * attached to a trace array. It temporarily holds event data for
+	 * triggers when tracing is off. Account for its pages too.
+	 */
+	if (temp_buffer) {
+		for_each_tracing_cpu(cpu)
+			stats.global += ring_buffer_memory_size(temp_buffer, cpu);
+	}
+
+	stats.total_system = stats.global + stats.instances +
+			     stats.snapshots + stats.remotes;
+	stats.total_carveout = stats.persistents;
+
+	return stats;
+}
+
+static int trace_mem_show(struct seq_file *m, void *v)
+{
+	struct trace_mem_stats stats = trace_buffers_memory();
+
+	seq_printf(m, "global: %lu\n", stats.global >> 10);
+	seq_printf(m, "instances: %lu\n", stats.instances >> 10);
+	seq_printf(m, "snapshots: %lu\n", stats.snapshots >> 10);
+	seq_printf(m, "persistents: %lu\n", stats.persistents >> 10);
+	seq_printf(m, "remotes: %lu\n", stats.remotes >> 10);
+	seq_printf(m, "total_system: %lu\n", stats.total_system >> 10);
+	seq_printf(m, "total_carveout: %lu\n", stats.total_carveout >> 10);
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
@@ -9313,6 +9414,18 @@ static struct notifier_block trace_module_nb = {
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
 	/*
@@ -9327,6 +9440,8 @@ static __init void tracer_init_tracefs_work_func(struct work_struct *work)
 	init_tracer_tracefs(&global_trace, NULL);
 	ftrace_init_tracefs_toplevel(&global_trace, NULL);
 
+	init_trace_stats_tracefs();
+
 	trace_create_file("tracing_thresh", TRACE_MODE_WRITE, NULL,
 			&global_trace, &tracing_thresh_fops);
 
-- 
2.34.1

