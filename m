Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F78949B5D5
	for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Sep 2026 15:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789141838; cv=none; b=cOOd/8KwPXmPpTxrshGlf1FFLT4GpHA0wrddzf8MvZDXmJJ0tBsKrIOSxulfESZy2sZU1IObHCbtpJzo/HYTullOPhDfF9lCx4349cPerEkfsCg3GRD/0VfOFMLTqU6hYMeyFAwSGfu+FB6fDkA/2eB5XZ9GO8hzug4lcaXUaxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789141838; c=relaxed/simple;
	bh=WjYK3pzeawJSBXL1J2JOmg+my2lNZqZrxPiPYoz/Tl8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cFAPQmJgM/Khet5EQsE7te5OYpU/PJsHf36+yX6kKTn0CijRzfNW+8sdmg23ZMaEZSqaBClj4oW9MHLqlrju6T8psbbJBnCQbVfVzvw3xBS4Z/ptsCWIT4I0IWfEpfmfZSgX/9e2FHbd0OzqTL2MxfOZyCfOwCeP89RScH7QBBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m0bnwaM7; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0bnwaM7"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d8fe517774so13413645ad.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Sep 2026 08:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789141835; x=1789746635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7Ncv0qza4n7xU/ePfsTNxTo8wWj87uTeUF7PMp8e4PA=;
        b=m0bnwaM70MBDDbMHG2dmtifkm4kgWDkr/kNqZLn7v76TOBHb5X/uAvG3oZpdWYiCiy
         pDUj+BMYPb4r8CMoWBkIQodB6C0hvoMySSJn2+uVEEkTsKYDJIUJhI4vFcAiIwuRVaKA
         g47d40UE42bm74PZeOERzoPaPmQ+S+QHww8aPfc4VnF0ul4+81pbgl243pBZsdXjX5Zx
         6U8wwNPXod0tcTSrLu6DD9obVrlgZRqfJXfvodL31hTrKol/qxg4ieUfhXB9DMuQZmaZ
         SYBH2cAvkW0O0h1A7TpQa141e8gjJRLxPkXYOXsXx2pxBz9yxjlnBdlQh7NbrUZOjHnB
         icHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789141835; x=1789746635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7Ncv0qza4n7xU/ePfsTNxTo8wWj87uTeUF7PMp8e4PA=;
        b=J7WQjeEnSAW5o1NEd8JbuWuhvd+4cS5TwNiyoIwtGjntndxK+9s84MYMq4I/nz+6yx
         DucaSES6l0nM+GlKh779OJN7Ei4ZkhH4gNbV3Uort55GqYIwZ29yFOAjXOceVVYjjxWp
         fJxAuviNT/3gFiA10bMNpMsdGtcT7iMQyZvguhtRGvQ8TqaSCJiDkNKrcDh407j12Ozw
         GFcarAk3QUwqzl6eRjHoNjGXDpgY0pOLs+wLeOJr2NmIQfSZDemOSlCkRFZQT5aWMagK
         60MYortzy2rcTxfCGqGEBR8A6IDl2ZK0P6NHI2D9tcY3wXSBFtxlNcQoCRChB16YkViD
         Kmag==
X-Forwarded-Encrypted: i=1; AKwUvBxPTex61l9wWGhmrIL6zdKIWF6BF3zOaef2lOdohJDUJToS4v09J+B6B6FQywzN95yxpZKkyqElr8bObWuyoGMtev0=@vger.kernel.org
X-Gm-Message-State: AFuF++kANMmmIVAqe4v9UzWHXPhbiTp4MW4ebGvCM9zw5otOsPq4xgeY
	mH5cHg9BFnKz5UJ20zKGvA/nc7T3Dt0yM2ZxAYNlfHnOp1JVj/k8l/Ij
X-Gm-Gg: AYBFou0hXyXD/75ScvnGwnQadhz1wcczlCaozDRB0hpSulh2yAg+Jbh8J+LtflEJf9G
	gG4GlTj5ex96d3doJ+eFGSMoV/xg/cPPqVHfYKGNGfVaNvAYF/gKsIfaTYYZ/kbzrm/W6FO9tRh
	HCFFE/UBwFub+TQTwLwGXVmhcbLYZs096RCNgKSBgQ1RYw2gLdNoN57s13u3Vz+X29sjpYSCyUl
	RMjB543Mp1jQsmbtg4NyvqxbSQ0K8+QWGlVx7jtzjWGnychbKa1ZwsYB3vobwELJDV3hbDXcRPW
	WykujkOAqW2oNrxtItUEar/wUzQvAgyUwgAJJ5n7hrcWOc197pwix5TU6JRa6Up3s4p1pJPOX2Y
	Sd5IHkoa8abOdu+cHXNq8X8vUy+cy6tH9qiS9dT14LMtxXpgf9+ChPkN79s+FF3IUQLFb0S1nXM
	wGQeiREgQNlWIfx1ND3MVb/3nvJ4/CxKDXJudjr1mguFNmMBBY1wZ2k/yxfVLlxZMoW3ByRVAlZ
	DKOHuHBYpKt1nrN8iSlT/XQBHxe9m/KfN8bfJM=
X-Received: by 2002:a17:902:ccc9:b0:2d7:3f6e:5cb9 with SMTP id d9443c01a7336-2dd2a1efc6amr98839165ad.8.1789141835370;
        Fri, 11 Sep 2026 08:50:35 -0700 (PDT)
Received: from bj-kjy-standalone-gaoxiang17.mioffice.cn ([43.224.245.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2cfcefb6sm13634895ad.56.2026.09.11.08.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 08:50:35 -0700 (PDT)
From: Xiang Gao <gxxa03070307@gmail.com>
X-Google-Original-From: Xiang Gao <gaoxiang17@xiaomi.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Vincent Donnefort <vdonnefort@google.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	gao xu <gaoxu2@honor.com>,
	yinchuang1@xiaomi.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiang Gao <gaoxiang17@xiaomi.com>
Subject: [PATCH v2 2/2] tracing: add per-CPU memory usage statistics in tracefs
Date: Fri, 11 Sep 2026 23:50:17 +0800
Message-Id: <20260911155017.3377254-3-gaoxiang17@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260911155017.3377254-1-gaoxiang17@xiaomi.com>
References: <20260905112732.3705405-1-gaoxiang17@xiaomi.com>
 <20260911155017.3377254-1-gaoxiang17@xiaomi.com>
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

