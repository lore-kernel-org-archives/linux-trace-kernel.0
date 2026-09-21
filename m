Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E004C4908B9
	for <linux-trace-kernel@vger.kernel.org>; Mon, 21 Sep 2026 11:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789990267; cv=none; b=lY2jGRmipbJLcUS5LoZJv++TVGmpaubKpE/g36MjWByEtqJNXhH0ry/NNKfqKoJuhnzl0hzAzqVM7fEl55Sql3NV60G2euowAmgC6CBbhDb+Xt0MklaPiOiCCk5lVSw3YWsnHVALPgW2xZwFZzd30Uq2FDLDpLomPr0wRO+6z5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789990267; c=relaxed/simple;
	bh=UIFR8tf0jH+Z6/LeosPsUYyPZl7jf62BEMiT9Hkjlsw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KJ+CwTDuhrbhG1ECYua8gnEf1igSyOsEBIS9U9In6QLLRXIILAE4aM8U6kZrz8hTM9CnKQLXyrO0JzY3kn9KIy8teH3KZVJ2oQysPwz63nR4pZWnY/X4VIEXg6jcPAbuKoYqGA68+woFbPBkCAxdBxhulWlv63HhBvtCzmZxbcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OnUd6eyg; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnUd6eyg"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-39b5b07ec78so1912894a91.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 21 Sep 2026 04:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789990265; x=1790595065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GXwttS8OODeGfpP/NZhHTaRMy64nJjuxHH+rjyaVcUM=;
        b=OnUd6eygD9nqsmYym8wo8sibEIzBqc0gufypcgIaTJR2EBzDxIFrisRHiZfIdEQ9oD
         bi17dqttKHDaRse4T6E0OvTghs0eA8/IsDBZmiGssOxdMa3Qipq4eEz7tJsC5ytGBH2S
         88/PGoRPyGtTiaD+wl15Or5c1Ffft8eCn8JvWgHCqpLyA3Fy+H+S6W/7Kk3TjO+Q8jsi
         BXm93KQNjtnPvjc6OUr2eBjFQMiprPsiKsMyBkRXKbY2MgQ7nmb9OC8rn+ZD6+5x2p6C
         3Q9XY5QRv/acJPjyuOn/XaFY4NP9nV8kZTzKM7V5GIHTUbkDBxhKSp919yMhBgL5Rut2
         Y3lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789990265; x=1790595065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GXwttS8OODeGfpP/NZhHTaRMy64nJjuxHH+rjyaVcUM=;
        b=p1j9kKJs7Pi2TVFNfRvGXebE4rA09yP0XQKTbI1BmV63vlprdFLL9doY8K1X2D15nB
         MkEr3l3XKlD9vBWmz257CgMwR5jyIkCmAieU7ZvPaKsipWtD2jNkeZKoB45GwIVv7NQP
         8sE45U9shxv82jx5dYDGcfCAn+mUwNGT2f47sWXPA+8SkgpPwxkuxa+MnUoG9RhWa6EJ
         AgWRgIJAzNzpdT7HDN5vFYrAgcpmcLHb09CsBvi7IrD3ld5P7HLZ5zMpcYzq/PgRrsW0
         4LZZ2d+p5QrXCvopGqyLW6Q9UpZFjKj+v+bLkLwHLrtjNFLDYGFxgIKeMjZqAbYlImGv
         AujA==
X-Forwarded-Encrypted: i=1; AKwUvBzcQdgwVuLTRWooNYrW7QySQ7774BB1CERezSz0RbMmbtEcaTyVyg3qjLb5ERG+xVNkIdoVKtcfxLiE9KM2uJVoRho=@vger.kernel.org
X-Gm-Message-State: AFuF++l0K528dn+oBzpCmPQS8uje1qQ8W4XcqgCqoIf3nfTm2SqRsC0h
	A5YhopnlWZy6y9hsY4CC9VPsX5w2iBgYXkzpbpmWcxaXYqTdxvs5xeFFjOSBEA==
X-Gm-Gg: AYBFou0zTeNJRV2UsT1X7vWOyBB0qEIAp6uolP+x+DhFKA/0tgybUWjPCVd9Kj8WZeq
	z8IxGB17IoaVjjeaQzkRViwyeJy9REeVsz5jNvTebYDf4qkRDqFVYdYshyUDRMhEJJNo8cHyBLe
	hD6akhs9OUUbLwln+tdLC0odNLsDiJZfauH8/Wjj54j/4jKm1wlPWO66VQj7e33/FK6fStHv6QL
	/xbxf0rDRs+Exk91FGEGF9IYPkCKdIfHNHEO9mrIQiwbYYfO+UgpL/pca7dQTVh9plFnyFRmXWR
	TrGAlMZrGW4no5RHdhtxGTJFsg9f0bmYy+4ImVjWbQHuGQ/PyOu0k23aj4Tkx0GZzGQvm2pCNid
	1Gv5gRXxDx17EW80omQLSx4n3I7A28B+oT/zsgQ+DNy0/U0loc3LFmTT0Ys7cI2RvI3HqVIprDS
	IdT7lemJaJmHemzKdSIxZ++SqoewSmfmCmm4bMUQDFVWz1EOpuU5ZyLg6/JOtLwMMMai+TxFGrP
	2eD8yd4TtdXLxDKe5wLv7yNSiEXMyCzg3oXENU=
X-Received: by 2002:a17:90b:562c:b0:3a0:516d:9f87 with SMTP id 98e67ed59e1d1-3a0516da897mr2088846a91.13.1789990264908;
        Mon, 21 Sep 2026 04:31:04 -0700 (PDT)
Received: from bj-kjy-standalone-gaoxiang17.mioffice.cn ([43.224.245.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6ca86d83sm14003444a91.6.2026.09.21.04.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 04:31:04 -0700 (PDT)
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
Subject: [PATCH v4 2/2] tracing: add per-CPU memory usage statistics in tracefs
Date: Mon, 21 Sep 2026 19:30:46 +0800
Message-Id: <20260921113047.1152602-3-gaoxiang17@xiaomi.com>
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

Provide a per-CPU view of the tracing ring-buffer memory usage under
trace_stats/per_cpu/cpuN/memory_usage_kb, using the same format as the
aggregate file. Each file reports only the buffers belonging to that CPU
across the global trace array and all tracing instances.

Signed-off-by: Xiang Gao <gaoxiang17@xiaomi.com>
---
 Documentation/trace/ftrace.rst |  3 ++
 kernel/trace/trace.c           | 67 +++++++++++++++++++++++++++++++++-
 2 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index 99ddfe26b7cd..e53cdd8d6702 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -230,6 +230,9 @@ of ftrace. Here is a list of some of the key files:
 	    buffers: ...
 	    snapshot_buffers: ...
 
+	The same file is provided under trace_stats/per_cpu/cpuN/, reporting
+	only the buffers belonging to that CPU.
+
   buffer_subbuf_size_kb:
 
 	This sets or displays the sub buffer size. The ring buffer is broken up
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index d4a913ff8a69..4010f28f3ebf 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5844,6 +5844,52 @@ static const struct file_operations trace_mem_fops = {
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
+		trace_array_buffer_memory(tr, cpu, &stats.buffers,
+					  &stats.snapshot);
+
+	/* Account for the bootstrapping temp_buffer as well. */
+	if (temp_buffer)
+		stats.buffers += ring_buffer_memory_size(temp_buffer, cpu);
+
+	return stats;
+}
+
+static int trace_mem_per_cpu_show(struct seq_file *m, void *v)
+{
+	struct trace_mem_stats stats = trace_buffers_memory_cpu((long)m->private);
+
+	seq_printf(m, "buffers: %lu\n", stats.buffers >> 10);
+	seq_printf(m, "snapshot_buffers: %lu\n", stats.snapshot >> 10);
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
@@ -9360,7 +9406,9 @@ static struct notifier_block trace_module_nb = {
 
 static __init void init_trace_stats_tracefs(void)
 {
-	struct dentry *stats_dir;
+	struct dentry *stats_dir, *per_cpu_dir, *cpu_dir;
+	char cpu_dir_name[30];
+	int cpu;
 
 	/*
 	 * tracer_alloc_buffers() frees tracing_buffer_mask and temp_buffer
@@ -9376,6 +9424,23 @@ static __init void init_trace_stats_tracefs(void)
 
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

