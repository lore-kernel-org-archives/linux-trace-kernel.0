Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793887384;
	b=LmWYdN45HNK/TH3nN3j5Vq2jwBBpFPRbyD/7ZOfTm0NT01/l5uP8Zi/010qZ7fioPVV4
	 CCy8TP/+rOccl2xCzjRTuRnxEOO6ABLAsHGhw1o/n69L8RVxxWC+LiLV8jpPpNpmqqxpx
	 P/O1oYulo1nBKnAhA9ErVETDGYM2532X2cFGu5zNX4t2fttyoS8R/5Z0DL6jK3WpE5po2
	 5//yshDG6RlLjqg/sa1ZaO5gTtYE4AdpqKB4l+Bc9f/nPm2hLCluxcKMT5jDXijObk+kU
	 Xgvg4M57WxNv3Zl6/bn+xLpft8DepE9O6P87vrOSfdmxbrop+C5ViYL+uLhS9M+BX9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793887384;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=OIhsjHfY+91mLh5ERTBbgCaSdhXDfj6pOLcBVrpf7dE=;
	b=tBM8yv+bFAcmHKYgVQgLt4SzaKlFul1g5widpcS+0m01hY6oJd6zmFlzbDDFW1MRdDxj
	 lhT/iaH14PIlgvQG2Z7rAX7MmF581ZBfG5H6K+JMF2JOlQZ7Tu7KaLJuqke7NN/f8dr/g
	 fftDSouYe6IG+T4jCExUqL40ZtkKJUWJ7KXdwCwS9jC6azszGsbOrALyCOMzLYMSvy7Nj
	 hu/M264TohZqJUr4Dm6C6aqdkIFHm9zdHzIblkuDDWihPZctfw3LgSdDnz2P5uPuVymzd
	 RkZLzGI1SBnL68TdcqcM8ZEsBWqHNbL5QB5QJ68+t4zNk74yXINRXLR8lR7cDZYcmHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ENP4g7uM;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7CA606A333
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Nov 2026 14:03:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE7CA606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ENP4g7uM
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-36a1947498bso5396096eec.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 05 Nov 2026 06:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793887383; x=1794492183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OIhsjHfY+91mLh5ERTBbgCaSdhXDfj6pOLcBVrpf7dE=;
        b=ENP4g7uMSMbYhu+BBPFSM+ov1cl3TLtkiv+NR5Zm9o66PfPSzGvWMAxPq1hEgdoAbj
         Q0u0gj0v5qXQl5pzvyMTkOvhMQsoPvda+9KglkcOwQeAWpghklVsQFGcXP2W7vs62Qat
         S8p2imnpd2cTIImdDGNX+4EquTWoMwOO4M4+rhTtKQAIjXx5D5VXDJXaJtFyMRiXuHo0
         SI6/S/YoBs6X7ix120CCdosaLh9FynSQrs996AYrLRmSvNt8/ZPdtNzt//M68NxgezzS
         /a6I1t33fP5R8lu29JQzwRAZknEeyN457PJfOD+aOCTNXSrftL6/hq7F75HK9/0i3XQ/
         vt9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793887383; x=1794492183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OIhsjHfY+91mLh5ERTBbgCaSdhXDfj6pOLcBVrpf7dE=;
        b=i2ZJ9/m0J+pcancajlivjDvP8ISwS0DGLCYUCb/sMdmv8PUjRy1WMA9NyNHTJwSh10
         9hletZOuTG2AAsznZk3IATWZsXyuygldhz5eEKphe9M/TPVBRplZlG0+pkNuXDnkAbfZ
         bqAD32+/kN9s/QF22AFD3HKgt+GGYMSNsGnM4czgXNJiJkNPx/Piz1cD+2wys9DGYeJc
         wlpJ1sAgmchvefRsQLDNB9bDEQz/MJ2P4j0bmlxNgmsTYLkEda7ahPs3uLI9V6qgH04Y
         hIvw6todQR3E5MmbIj/Td7YXFL8RIM+rPO9oPnFgOYh55K+ON+hNkwTjHIKILFYoJBPN
         QnKg==
X-Forwarded-Encrypted: i=1; AKwUvBz6jzVBpRPobTCTk1A4DdSQVPAzrDkVAQ3yqteJ1Sxl7XI0BST6SqeWEDITWwtTfHTh/BsU36FuMHQ40jx4hySUkfw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8O9hZxSZX9cR4m6qYz8TDSS+/RWlCu8OErENdjxWhQbFa+2yFr
	MnW5GsLEprcmx7N1XF41A42nEBQwdT0XjQ1nk/zxmTfB9YfSj90UKW1Q
X-Gm-Gg: AYBFou24vyrVQ7bq90Hv/WdS2v/Fd1m7l7iSdOPGBqc66bDUnxZA/0Hjoo3abP5h4sy
	vEbR3O/coZZkU+yLeDjEGi5oHVbyCeP42gIBIEY4P/DJPF8xGrk7DgHA4tqFEAiSu4Rj04Pge7p
	sRcMCXjoV2CNMnM5P/+mB3pay+deFuN6JxVVsvPlEP+wQhCVSvYQwM2zB/Qm1Afu59S+kXH4wJp
	gPiy9jCniiNhnBspEGs64oTERAdLc/fittWowtLBbVQA4DUTOgIZliaSHnpgYhxbeIIDAhspT8/
	suLg6AGWcOqLyEhUeMYOQjQWSS3NNM5xxdae4ZfcXtmkyPboLIkQBJ0CHr67YhgGKo4/RE88Dw9
	l5hYilj2nuf12hBB3TZPDM6a+wFO0Pgiq4+IdihcpA3acTWTFUjDYMaxTMfzveaZmNZ715Kg78L
	f7vA0GF7dyel49ewNP+6BR6QvNoj8liXF0Ng8CVMwP0GhxQ8JCo8UtGfeznsgnOy0m9dsdAuOAk
	shCYvP/03jepcrVpm3DBdraUonVQNu+0EZOxHNCYqHEp/Bmgnwf1MfS41NOPiJln79gLwsZF41o
	H+qcuL3sihCIXSz1b0iacM7hCNGe3pSQRmunMq2Bxi36DxdsEiszd2fcbtLxAe63SS7PRQ==
X-Received: by 2002:a05:701a:c907:b0:195:1a77:85f4 with SMTP id a92af1059eb24-1ac5ceee102mr26982844c88.24.1793887382662;
        Thu, 05 Nov 2026 06:03:02 -0800 (PST)
Received: from bj-kjy-standalone-gaoxiang17.mioffice.cn ([43.224.245.230])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca3981ff0sm20969616eec.24.2026.11.05.06.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 06:03:02 -0800 (PST)
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
Subject: [PATCH v5 3/4] tracing: add per-CPU buffer memory usage statistics
Date: Thu,  5 Nov 2026 22:02:20 +0800
Message-Id: <20261105140221.44614-4-gaoxiang17@xiaomi.com>
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

Provide a per-CPU view of the tracing ring-buffer memory usage under
trace_stats/per_cpu/cpuN/memory_usage_kb, using the same categorized
format as the aggregate file. Each file reports only the buffers
belonging to that CPU.

Signed-off-by: Xiang Gao <gaoxiang17@xiaomi.com>
---
 kernel/trace/trace.c | 75 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 74 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 6036e368fe10..e7e23ff38105 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5898,6 +5898,60 @@ static const struct file_operations trace_mem_fops = {
 	.release	= single_release,
 };
 
+static struct trace_mem_stats trace_buffers_memory_cpu(int cpu)
+{
+	struct trace_mem_stats stats = {};
+	struct trace_array *tr;
+
+	guard(mutex)(&trace_types_lock);
+
+	list_for_each_entry(tr, &ftrace_trace_arrays, list)
+		trace_array_buffer_memory(tr, cpu, &stats);
+
+	/* Account for the bootstrapping temp_buffer as well. */
+	if (temp_buffer)
+		stats.global += ring_buffer_memory_size(temp_buffer, cpu);
+
+	stats.total_system = stats.global + stats.instances +
+			     stats.snapshots + stats.remotes;
+	stats.total_carveout = stats.persistents;
+
+	return stats;
+}
+
+static int trace_mem_per_cpu_show(struct seq_file *m, void *v)
+{
+	struct trace_mem_stats stats = trace_buffers_memory_cpu((long)m->private);
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
+static int trace_mem_per_cpu_open(struct inode *inode, struct file *file)
+{
+	int ret;
+
+	ret = tracing_check_open_get_tr(NULL);
+	if (ret)
+		return ret;
+
+	return single_open(file, trace_mem_per_cpu_show, inode->i_private);
+}
+
+static const struct file_operations trace_mem_per_cpu_fops = {
+	.open		= trace_mem_per_cpu_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 #define LAST_BOOT_HEADER ((void *)1)
 
 static void *l_next(struct seq_file *m, void *v, loff_t *pos)
@@ -9416,7 +9470,9 @@ static struct notifier_block trace_module_nb = {
 
 static __init void init_trace_stats_tracefs(void)
 {
-	struct dentry *stats_dir;
+	struct dentry *stats_dir, *per_cpu_dir, *cpu_dir;
+	char cpu_dir_name[30];
+	int cpu;
 
 	stats_dir = tracefs_create_dir("trace_stats", NULL);
 	if (!stats_dir)
@@ -9424,6 +9480,23 @@ static __init void init_trace_stats_tracefs(void)
 
 	trace_create_file("memory_usage_kb", TRACE_MODE_READ, stats_dir,
 			  NULL, &trace_mem_fops);
+
+	per_cpu_dir = tracefs_create_dir("per_cpu", stats_dir);
+	if (!per_cpu_dir)
+		return;
+
+	for_each_tracing_cpu(cpu) {
+		snprintf(cpu_dir_name, 30, "cpu%d", cpu);
+		cpu_dir = tracefs_create_dir(cpu_dir_name, per_cpu_dir);
+		if (!cpu_dir) {
+			pr_warn("Could not create tracefs '%s' entry\n",
+				cpu_dir_name);
+			continue;
+		}
+
+		trace_create_file("memory_usage_kb", TRACE_MODE_READ, cpu_dir,
+				  (void *)(long)cpu, &trace_mem_per_cpu_fops);
+	}
 }
 
 static __init void tracer_init_tracefs_work_func(struct work_struct *work)
-- 
2.34.1

