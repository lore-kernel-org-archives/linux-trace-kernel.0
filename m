Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4216444A3F0
	for <linux-trace-kernel@vger.kernel.org>; Sat,  5 Sep 2026 11:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788607680; cv=none; b=oQpmKEMZRTDoNDIgE23dW1nYdfHe4H3MoFCawudIBWpWt5bLJsqbJH8FTDdugALqsGzMCDXN2+2t2A+J+nCIv3Q0dGOI2R/7szcM75oPqzD3WOV8mj7XuUNBLpEsvWNoDdTPiKRsZE6u+gIsnFCi3OnvDsjYIIO+jmYUwzEN9jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788607680; c=relaxed/simple;
	bh=WjYK3pzeawJSBXL1J2JOmg+my2lNZqZrxPiPYoz/Tl8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Co/EWvQSgMJKZVz7fGA515tqq1MGIwQ0/KzJQu94m4C8t/N3hHUEzytR18A8Aue2nFcEVCPF1D3zeTDTlroNgpQglD82/pBBfY346TW3iHDZ0/NbzcWTUVna+JJTR1Parg5M9RyY52zyyHytx1H2pYemktgKk0m3PBVhSwbXHpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqyGPXR3; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqyGPXR3"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8487214ad2bso2116805b3a.1
        for <linux-trace-kernel@vger.kernel.org>; Sat, 05 Sep 2026 04:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788607677; x=1789212477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7Ncv0qza4n7xU/ePfsTNxTo8wWj87uTeUF7PMp8e4PA=;
        b=nqyGPXR3xHd1juHLW/YnZb+9IZQ96DbnWTilkPOJzzBE3LrdpslTNLl5663Ed5t7xg
         tkexMyBB33el8kZvt2P/abmrOZva7eERHgOlCdlWKxJOD77PQRtjkwnyKFJZelCgxqmA
         q2hGwmsy7+zLGjTonVCMQMZIiq3Vd32R1P7wViG6y1OJ+IzEQjZWZeuIwKdcK7MMO4If
         4CyZnnnyIgH4Xdfwk4GmlNCGM6IyNazncPNJDdMfy/h8QaLRdzXRjP+7Pzdoynf1BAwA
         /c33zpwMGRcd3nq/DNllmbjbhXTPhfPts7bV762dkbTPsfvj143mohqBnEgIudooJ1+F
         o9Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788607677; x=1789212477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7Ncv0qza4n7xU/ePfsTNxTo8wWj87uTeUF7PMp8e4PA=;
        b=RRfm72i9RBxzR2TGDozjTG8vYZfnR0MWp92LHHBKRmBUH1N3tiMoF8K+vEZKa4B4qb
         bLT05nHplLhQbC3LGIi8ZXEwQkHYLpgs4dRK410lyC6ZBZ6YtljowYmYc00q0vgvyd7I
         FcasDWQTB+OPlbLTmz7N3tY2M6A122NIOLmDCN/XTXqVTPHpQLbj0+zo2P0M7CmbO+er
         5x1FNLkWWhYXXQqkiSUDrJxaW52tzxDvheT4x6OtrhmWs0S7IV4c4OXQ4j9Ov0vuk+3B
         tDxe/hx34SXCYnMOWOBwR5Dm209RTK/Ay4ZBMkBS/4+7N0ptyCMbCcfXE0XX87qQgV3D
         bylg==
X-Forwarded-Encrypted: i=1; AKwUvBxDCcUbYe0y059kNmejwBKi5KcneSHuruYtWRoBiD8BXK9IgcF2uRDXwzBJzQsP9cJNG8xFoXxEzb5ldOgSdUYTwvw=@vger.kernel.org
X-Gm-Message-State: AFuF++k3zJ1AzWvE/HTfO3YiPEvLRXISjOVDHWJTHZOmchWq3Othm+yX
	71L8+uAxNW5pMJNjDUjB4umVf3x8ZKazN0K0EszPHdT7eD1G9lnjY47E
X-Gm-Gg: AYBFou3YthrSuCJ8XW8X00tPa4KuUQobhDlAvqKp0KzVYjBoKjy6zqMdwV44ytKufs5
	JLGssOvd4Qwr3ssKoogfFnFI4N0mNdj8LNFNp4pMwAk+WHY5e2t1tbTVz8wzdCuSViKMbGQ21+8
	rZwd2aJG8xsn9Ls6OzvWF62WqJvYBmlSqSbH8iHUWjs1OR+Az4xhrYvgChP9RuAoc2a0bK9JR1W
	R3g7Jl/dquRG1vlubSASmSc81XYV0n4kNGJO1UYtDJdNKU3KYxqFmoZITQMAnmwh6XGe6xO0AcY
	4dOrct/1dsZeUdnmX8o2phNJGGCgTDP+yBSYTBo4SHgRbf5Y9YJ9AqXKDiPpiSYdQQye5NgqBEJ
	rrQyN+8VY8ag5mTbXC/XXJEx5D2LZtPiOkVOq023mQk3zegxrAzCAMAN0kxecp11wjLEgrlgyN1
	lbdxyfcfQyi2kH+TglN2mX3gZE7+cb0474pIlwJteUu2zh0tAnJP9cKGNQ+8fJEaWEtUhf1vdN0
	HROmaAbTrca8cJtMyqV5a933n/x
X-Received: by 2002:a05:6a00:a204:b0:852:5f99:1866 with SMTP id d2e1a72fcca58-861653da118mr14724734b3a.0.1788607677497;
        Sat, 05 Sep 2026 04:27:57 -0700 (PDT)
Received: from bj-kjy-standalone-gaoxiang17.mioffice.cn ([43.224.245.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86152e39a38sm2228779b3a.39.2026.09.05.04.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 04:27:56 -0700 (PDT)
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
Subject: [PATCH 2/2] tracing: add per-CPU memory usage statistics in tracefs
Date: Sat,  5 Sep 2026 19:27:32 +0800
Message-Id: <20260905112732.3705405-3-gaoxiang17@xiaomi.com>
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

Provide a per-CPU view of the tracing ring-buffer memory usage under
trace_stats/per_cpu/cpuN/memory_usage_kb, using the same format as the
aggregate file. Each file reports only the buffers belonging to that CPU
across the global trace array and all tracing instances.

Signed-off-by: Xiang Gao <gaoxiang17@xiaomi.com>
---
 Documentation/trace/ftrace.rst |  3 +++
 kernel/trace/trace.c           | 46 +++++++++++++++++++++++++++++++++-
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index ff9d604dd1b8..694c9ed8f241 100644
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
index b343e03a6cf8..ea05077af4a0 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5815,6 +5815,31 @@ static int trace_mem_show(struct seq_file *m, void *v)
 }
 DEFINE_SHOW_ATTRIBUTE(trace_mem);
 
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
+DEFINE_SHOW_ATTRIBUTE(trace_mem_per_cpu);
+
 #define LAST_BOOT_HEADER ((void *)1)
 
 static void *l_next(struct seq_file *m, void *v, loff_t *pos)
@@ -9236,7 +9261,9 @@ static struct notifier_block trace_module_nb = {
 
 static __init void init_trace_stats_tracefs(void)
 {
-	struct dentry *stats_dir;
+	struct dentry *stats_dir, *per_cpu_dir, *cpu_dir;
+	char cpu_dir_name[30];
+	int cpu;
 
 	stats_dir = tracefs_create_dir("trace_stats", NULL);
 	if (!stats_dir)
@@ -9244,6 +9271,23 @@ static __init void init_trace_stats_tracefs(void)
 
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

